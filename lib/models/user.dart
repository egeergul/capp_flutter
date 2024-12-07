class User {
  String deviceId;
  int createdAt;
  int updatedAt;

  User({
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromValues({
    required String deviceId,
    int? createdAt,
    int? updatedAt,
  }) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    return User(
      deviceId: deviceId,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? createdAt ?? now,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      deviceId: json['deviceId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'User{deviceId: $deviceId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
