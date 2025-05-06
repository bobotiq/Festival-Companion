class Friend {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;

  Friend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json['id'] as String,
        name: json['name'] as String,
        avatarUrl: json['avatarUrl'] as String,
        isOnline: json['isOnline'] == 'true' || json['isOnline'] == true,
      );
}
