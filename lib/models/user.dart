class User {
  String deviceId;
  int createdAt;
  int updatedAt;
  int totalChats;

  User({
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalChats,
  });

  factory User.fromValues({
    required String deviceId,
    int? createdAt,
    int? updatedAt,
    int? totalChats,
  }) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    return User(
      deviceId: deviceId,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? createdAt ?? now,
      totalChats: totalChats ?? 0,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      deviceId: json['deviceId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      totalChats: json['totalChats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'totalChats': totalChats,
    };
  }

  @override
  String toString() {
    return 'User{deviceId: $deviceId, createdAt: $createdAt, updatedAt: $updatedAt, totalChats: $totalChats}';
  }
}
