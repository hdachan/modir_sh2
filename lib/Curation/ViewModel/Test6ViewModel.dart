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
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 병렬로 데이터 가져오기
      final results = await Future.wait([
        _userService.fetchUserInfo(userId),
        _userService.fetchUserPostLikeCount(userId),
        _userService.fetchUserPostCount(userId),
        _userService.fetchUserFeeds(userId), // 사용자 게시물 가져오기
      ]);

      userInfo = results[0] as UserInfo;
      likeCount = results[1] as int;
      postCount = results[2] as int;
      userFeeds = results[3] as List<Feed>; // 사용자 게시물 저장
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}