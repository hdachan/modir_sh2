import 'package:flutter/material.dart';
import '../Service/user_service.dart';
import '../models/user_info.dart';

class Test6ViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  UserInfo? userInfo;
  int? likeCount;
  bool isLoading = false;
  String? errorMessage;

  // 사용자 정보와 좋아요 개수 가져오기
  Future<void> fetchUserData(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 사용자 정보와 좋아요 개수를 병렬로 가져오기
      final results = await Future.wait([
        _userService.fetchUserInfo(userId),
        _userService.fetchUserPostLikeCount(userId),
      ]);

      userInfo = results[0] as UserInfo;
      likeCount = results[1] as int;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}