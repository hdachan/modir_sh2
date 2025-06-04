class UserInfo {
  final String id; // UUID
  final String username;
  final String category;

  UserInfo({
    required this.id,
    required this.username,
    required this.category,
  });

  // Supabase에서 받아온 JSON 데이터를 모델로 변환
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      username: json['username'] as String,
      category: json['category'] as String,
    );
  }

  // JSON으로 변환 (필요 시)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'category': category,
    };
  }
}