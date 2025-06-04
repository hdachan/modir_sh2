import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../sevices/FeedService.dart';
import '../sevices/supabase_service.dart';

class Screen3ViewModel with ChangeNotifier {
  final FeedService _feedService;
  final SupabaseService _supabaseService;
  List<Uint8List> _images = [];
  bool _isSaving = false;

  List<Uint8List> get images => _images;
  bool get isSaving => _isSaving;

  Screen3ViewModel(this._feedService, this._supabaseService);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      _images.add(bytes);
      notifyListeners();
    }
  }

  Future<void> saveAll({
    required String userId,
    required String title,
    required String content,
    required List<String> categoryItems,
    required List<String> welcomeItems,
    String? curationTitle,
    String? curationContent,
    Map<String, List<Map<String, String>>>? curationMap,
    Uint8List? feedImageBytes,
  }) async {
    if (title.isEmpty || content.isEmpty || categoryItems.isEmpty || welcomeItems.isEmpty) {
      throw Exception('All required fields (title, content, categories, welcome messages) must be provided');
    }
    if ((curationTitle == null || curationContent == null) && (curationMap == null || curationMap.isEmpty)) {
      throw Exception('Curation data (either single curation or curation map) must be provided');
    }

    _isSaving = true;
    notifyListeners();

    try {
      // 피드 저장
      final feedId = await _feedService.addFeed(
        userId,
        title,
        content,
        imageBytes: feedImageBytes,
      );
      print('Feed saved with ID: $feedId');

      // 카테고리 저장 및 category_id 반환
      List<Map<String, dynamic>> categoryIds = await _supabaseService.insertCategories(categoryItems, userId, feedId);
      Map<String, int> categoryIdMap = {
        for (var cat in categoryIds) cat['category_name'] as String: cat['id'] as int
      };
      print('Categories inserted: $categoryItems, IDs: $categoryIdMap');

      // 환영 메시지 저장
      if (welcomeItems.isNotEmpty) {
        await _supabaseService.insertWelcomeMessages(welcomeItems, feedId);
        print('Welcome messages inserted: $welcomeItems');
      }

      // 이미지 업로드
      List<String> imageUrls = [];
      for (var image in _images) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_$userId.jpg';
        await Supabase.instance.client.storage
            .from('curation_images')
            .uploadBinary(fileName, image, fileOptions: const FileOptions(contentType: 'image/jpeg'));
        final url = Supabase.instance.client.storage.from('curation_images').getPublicUrl(fileName);
        imageUrls.add(url);
      }
      print('Images uploaded: $imageUrls');

      // 큐레이션 저장
      if (curationContent != null && curationContent.isNotEmpty && curationTitle != null && categoryItems.isNotEmpty) {
        final categoryId = categoryIdMap[categoryItems.first];
        if (categoryId == null) {
          throw Exception('No valid category_id found for ${categoryItems.first}');
        }
        await _supabaseService.insertCurationList(
          feedId: feedId,
          title: curationTitle,
          content: curationContent,
          imageUrls: imageUrls,
          categoryId: categoryId,
        );
        print('Single curation inserted: $curationTitle, $curationContent, categoryId: $categoryId');
      } else if (curationMap != null) {
        final filteredMap = Map<String, List<Map<String, String>>>.fromEntries(
          curationMap.entries.where((entry) => entry.value.isNotEmpty),
        );
        if (filteredMap.isNotEmpty) {
          await _supabaseService.insertCurationLists(
            feedId: feedId,
            curationMap: filteredMap,
            imageUrls: imageUrls,
            categoryIds: categoryIdMap,
          );
          print('Curation lists inserted: $filteredMap');
        } else {
          print('No valid curation items to insert');
        }
      }
    } catch (e) {
      print('Error in saveAll: $e');
      rethrow;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  void clear() {
    _images = [];
    _isSaving = false;
    notifyListeners();
  }
}