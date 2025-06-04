import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_info.dart';

class UserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 사용자 정보 가져오기
  Future<UserInfo> fetchUserInfo(String userId) async {
    try {
      final response = await _supabase
          .from('userinfo')
          .select()
          .eq('id', userId)
          .single();

      return UserInfo.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching user info: $e');
    }
  }

  // 사용자가 작성한 게시물의 좋아요 개수 가져오기
  Future<int> fetchUserPostLikeCount(String userId) async {
    try {
      // 1. 사용자가 작성한 게시물의 feed_id 목록 가져오기
      final feedResponse = await _supabase
          .from('feed')
          .select('feed_id')
          .eq('user_id', userId);

      final feedIds = feedResponse.map((feed) => feed['feed_id'] as int).toList();

      if (feedIds.isEmpty) {
        return 0; // 사용자가 작성한 게시물이 없으면 좋아요 개수는 0
      }

      // 2. 해당 feed_id에 대한 좋아요 개수 세기
      final likeResponse = await _supabase
          .from('feed_like')
          .select()
          .inFilter('feed_id', feedIds)
          .count(CountOption.exact);

      return likeResponse.count;
    } catch (e) {
      throw Exception('Error fetching user post like count: $e');
    }
  }
}