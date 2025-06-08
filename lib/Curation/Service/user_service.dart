import 'package:supabase_flutter/supabase_flutter.dart';
import '../../feed/models/Feedmodel.dart';
import '../models/user_info.dart';

class UserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 사용자 정보 가져오기
  Future<UserInfo?> fetchUserInfo(String userId) async {
    try {
      final response = await _supabase
          .from('userinfo')
          .select()
          .eq('id', userId)
          .maybeSingle(); // .single() 대신 .maybeSingle() 사용

      if (response == null) {
        // 데이터가 없으면 null 반환
        return null;
      }

      return UserInfo.fromJson(response);
    } catch (e) {
      print('Error fetching user info: $e');
      return null; // 오류 발생 시 null 반환
    }
  }

  // 사용자가 작성한 게시물의 좋아요 개수 가져오기
  Future<int> fetchUserPostLikeCount(String userId) async {
    try {
      final feedResponse = await _supabase
          .from('feed')
          .select('feed_id')
          .eq('user_id', userId);

      final feedIds = feedResponse.map((feed) => feed['feed_id'] as int).toList();

      if (feedIds.isEmpty) {
        return 0;
      }

      final likeResponse = await _supabase
          .from('feed_like')
          .select()
          .inFilter('feed_id', feedIds)
          .count(CountOption.exact);

      return likeResponse.count;
    } catch (e) {
      print('Error fetching user post like count: $e');
      return 0; // 오류 시 0 반환
    }
  }

  // 게시물 개수
  Future<int> fetchUserPostCount(String userId) async {
    try {
      final response = await _supabase
          .from('feed')
          .select()
          .eq('user_id', userId)
          .count(CountOption.exact);

      return response.count;
    } catch (e) {
      print('Error fetching user post count: $e');
      return 0;
    }
  }

  // 게시물 가져오기
  Future<List<Feed>> fetchUserFeeds(String userId) async {
    try {
      final response = await _supabase
          .from('feed')
          .select('''
          feed_id, user_id, title, content, created_at, hits, status,
          userinfo: user_id (username),
          pic (pic_url),
          feed_like (user_id),
          sum_like: feed_like!feed_id (count)
        ''')
          .eq('user_id', userId)
          .eq('status', 0)
          .order('created_at', ascending: false);

      return response.map((json) {
        final username = json['userinfo']['username'] ?? 'Unknown';
        final liked = userId != null &&
            json['feed_like'] != null &&
            (json['feed_like'] as List).any((like) => like['user_id'] == userId);
        final sumLike = json['sum_like'] != null ? json['sum_like'][0]['count'] : 0;

        return Feed.fromJson({
          ...json,
          'username': username,
          'liked': liked,
          'sum_like': sumLike,
        });
      }).toList();
    } catch (e) {
      print('Error fetching user feeds: $e');
      return [];
    }
  }
}