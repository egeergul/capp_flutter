enum MessageType { user, ai, appTyping, nil }

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
  Map<String, dynamic>? metaData;

  Message({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.content,
    this.image,
    this.metaData,
  });

  factory Message.fromValues({
    String? id,
    required MessageType type,
    required String content,
    int? createdAt,
    int? updatedAt,
    String? image,
    Map<String, dynamic>? metaData,
  }) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    return Message(
      id: (id ?? createdAt ?? now).toString(),
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? createdAt ?? now,
      type: type,
      content: content,
      image: image,
      metaData: metaData,
    );
  }

  // TODO: make sure that the image is not very very big
  // use compression if needed
  final imageStringSplitRange = 240000;
  List<String> _splitImage(String image) {
    List<String> parts = [];
    for (int i = 0; i < image.length; i += imageStringSplitRange) {
      parts.add(image.substring(
          i,
          i + imageStringSplitRange > image.length
              ? image.length
              : i + imageStringSplitRange));
    }
    return parts;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      type: getMessageStatusFromString(json['type']),
      content: json['content'],
      image: json["image"] == null
          ? null
          : (json['image'] as List<dynamic>).join(),
      metaData: json["metaData"] == null
          ? null
          : (json['metaData'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson({bool withoutImage = false}) {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'type': type.name,
      'content': content,
      'image': withoutImage
          ? null
          : image != null
              ? _splitImage(image!)
              : null,
      'metaData': metaData,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, type: ${type.name}, content: $content, image: ${image != null ? 'yes' : 'no'}, metaData: $metaData}';
  }
}
