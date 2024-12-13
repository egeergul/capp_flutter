import 'dart:convert';

import 'package:capp_flutter/api/api_constants.dart';
import 'package:capp_flutter/helpers/extensions.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/message.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenaiApi {
  static OpenaiApi instance = OpenaiApi();

  String? getSystemMessage(ChatType type) {
    switch (type) {
      case ChatType.imageAnalyser:
        return ApiConstants.analyzeImageSystemMessageV1;
      default:
        return null;
    }
  }

  List<Map<String, dynamic>> formatPreviousMessages(Chat chat) {
    List<Map<String, dynamic>> res = [];
    String? systemMessage = getSystemMessage(chat.type);

    if (systemMessage != null) {
      res.add({"role": "system", "content": systemMessage});
    }

    for (var message in chat.messages) {
      if (message.type == MessageType.user) {
        Map<String, dynamic>? messageImage;
        if (message.image != null) {
          final imgStr = "data:image/jpeg;base64,${message.image}";
          messageImage = {
            "type": "image_url",
            "image_url": {"url": imgStr},
          };
        }
        Map<String, dynamic> userMessage = {
          "role": "user",
          "content": [
            {"type": "text", "text": message.content},
            if (messageImage != null) messageImage,
          ],
        };

        res.add(userMessage);
      } else if (message.type == MessageType.ai) {
        Map<String, dynamic> aiMessage = {
          "role": "assistant",
          "content": [
            {"type": "text", "text": message.content},
          ],
        };

        res.add(aiMessage);
      }
    }

    return res;
  }

  Future<Map<String, dynamic>> sendMessage({
    String model = "gpt-4o",
    required Chat chat,
  }) async {
    var header = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${dotenv.env['OPEN_AI_KEY'] ?? ""}',
    };

    var body = jsonEncode(
      {
        "model": model,
        "messages": [
          ...formatPreviousMessages(chat),
        ],
        "temperature": 0.7
      },
    );

    var response = await http.post(
      Uri.parse(ApiConstants.openAiChatCompletions),
      headers: header,
      body: body,
    );

    return jsonDecode(response.body);
  }
}
