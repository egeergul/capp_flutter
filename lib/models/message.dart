enum MessageType { user, app, ai, nil }

MessageType getMessageStatusFromString(String? str) =>
    MessageType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => MessageType.nil,
    );

class Message {
  String id;
  int createdAt;
  int updatedAt;
  MessageType type;
  String content;
  String? image;

  Message({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.content,
    this.image,
  });

  factory Message.fromValues({
    String? id,
    required MessageType type,
    required String content,
    int? createdAt,
    int? updatedAt,
    String? image,
  }) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    return Message(
      id: (id ?? createdAt ?? now).toString(),
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? createdAt ?? now,
      type: type,
      content: content,
      image: image,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      type: getMessageStatusFromString(json['type']),
      content: json['content'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'type': type.name,
      'content': content,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, type: ${type.name}, content: $content, image: ${image != null ? 'yes' : 'no'}}';
  }
}
