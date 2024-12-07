import 'dart:convert';

import 'package:capp_flutter/api/api_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenaiApi {
  static OpenaiApi instance = OpenaiApi();

  Future<Map<String, dynamic>> sendMessage({
    String model = "gpt-4o",
    String? systemMessage,
    String? userMessage,
    String? base64Image,
  }) async {
    String? imgStr;
    if (base64Image != null) {
      imgStr = "data:image/jpeg;base64,$base64Image";
    }

    var header = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${dotenv.env['OPEN_AI_KEY'] ?? ""}',
    };

    var response = await http.post(
      Uri.parse(ApiConstants.openAiChatCompletions),
      headers: header,
      body: jsonEncode(
        {
          "model": model,
          "messages": [
            if (systemMessage != null) ...[
              {"role": "system", "content": systemMessage},
            ],
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": userMessage,
                },
                if (imgStr != null) ...[
                  {
                    "type": "image_url",
                    "image_url": {"url": imgStr},
                  },
                ],
              ],
            },
          ],
          "temperature": 0.7
        },
      ),
    );

    return jsonDecode(response.body);
  }
}
