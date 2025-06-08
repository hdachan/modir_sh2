class UserInfo {
  final String? id;
  final String? username;
  final String? category;

  UserInfo({this.id, this.username, this.category});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String?,
      username: json['username'] as String?, // null 허용
      category: json['category'] as String?, // null 허용
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'category': category,
    };
  }
}