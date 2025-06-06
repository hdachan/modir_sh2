import 'package:flutter/material.dart';
import '../../feed/models/Feedmodel.dart';
import '../Service/user_service.dart';
import '../models/user_info.dart';


class Test6ViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  UserInfo? userInfo;
  int? likeCount;
  int? postCount;
  List<Feed> userFeeds = []; // 사용자 게시물 리스트 추가
  bool isLoading = false;
  String? errorMessage;

  // 사용자 정보, 좋아요 개수, 게시물 수, 사용자 게시물 가져오기
  Future<void> fetchUserData(String userId) async {
    print('Fetching user data for userId: $userId');
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _userService.fetchUserInfo(userId).then((result) {
          print('fetchUserInfo completed');
          return result;
        }),
        _userService.fetchUserPostLikeCount(userId).then((result) {
          print('fetchUserPostLikeCount completed');
          return result;
        }),
        _userService.fetchUserPostCount(userId).then((result) {
          print('fetchUserPostCount completed');
          return result;
        }),
        _userService.fetchUserFeeds(userId).then((result) {
          print('fetchUserFeeds completed');
          return result;
        }),
      ]);

      userInfo = results[0] as UserInfo;
      likeCount = results[1] as int;
      postCount = results[2] as int;
      userFeeds = results[3] as List<Feed>;
    } catch (e) {
      print('Error in fetchUserData: $e');
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      print('fetchUserData completed, isLoading: $isLoading');
      notifyListeners();
    }
  }
}