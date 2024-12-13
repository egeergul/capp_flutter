import 'package:capp_flutter/models/models.dart';

enum ChatStatus {
  initial,
  waiting,
  processing,
  completed,
  failed,
  deleted,
  nil,
}

ChatStatus getChatStatusFromString(String? str) => ChatStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ChatStatus.nil,
    );

enum ChatType {
  imageAnalyser,
  colorPaletteDetector,
  colorPaletteGenerator,
  nil,
}

ChatType getChatTypeFromString(String? str) => ChatType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ChatType.nil,
    );

class Chat {
  String id;
  String deviceId;
  int createdAt;
  int updatedAt;
  List<Message> messages;
  int totalInputTokens;
  int totalOutputTokens;
  ChatStatus status;
  ChatType type;

  Chat({
    required this.id,
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
    required this.totalInputTokens,
    required this.totalOutputTokens,
    required this.status,
    required this.type,
  });

  factory Chat.empty() {
    return Chat.fromValues(id: "-1", deviceId: "-1");
  }

  factory Chat.fromValues({
    required String id,
    required String deviceId,
    List<Message>? messages,
    int? createdAt,
    int? updatedAt,
    int? totalInputTokens,
    int? totalOutputTokens,
    ChatStatus? status,
    ChatType? type,
  }) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    return Chat(
      id: id,
      deviceId: deviceId,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? createdAt ?? now,
      messages: messages ?? [],
      totalInputTokens: totalInputTokens ?? 0,
      totalOutputTokens: totalOutputTokens ?? 0,
      status: status ?? ChatStatus.initial,
      type: type ?? ChatType.imageAnalyser,
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      deviceId: json['deviceId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      messages: (json['messages'] as Map<String, dynamic>)
          .values
          .map((e) => Message.fromJson(e))
          .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt)),
      totalInputTokens: json['totalInputTokens'],
      totalOutputTokens: json['totalOutputTokens'],
      status: getChatStatusFromString(json['status']),
      type: getChatTypeFromString(json['type']),
    );
  }

  Map<String, dynamic> toJson({bool withoutImage = false}) {
    return {
      'id': id,
      'deviceId': deviceId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'messages': {
        for (Message message in messages)
          message.id: message.toJson(withoutImage: withoutImage)
      },
      'totalInputTokens': totalInputTokens,
      'totalOutputTokens': totalOutputTokens,
      'status': status.name,
      'type': type.name,
    };
  }

  @override
  String toString() {
    return 'Chat{id: $id, deviceId: $deviceId, createdAt: $createdAt, updatedAt: $updatedAt, messages: $messages, totalInputTokens: $totalInputTokens, totalOutputTokens: $totalOutputTokens, status: ${status.name}, type: ${type.name}}';
  }
}
