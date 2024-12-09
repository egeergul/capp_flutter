import 'dart:convert';
import 'dart:typed_data';

import 'package:capp_flutter/controllers/controllers.dart';
import 'package:capp_flutter/models/message.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:capp_flutter/widgets/widgets.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatScreenController controller = Get.put(ChatScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.chat.value.messages.length,
                itemBuilder: (context, index) {
                  Message message = controller.chat.value.messages[index];

                  return MessageBox(message: message);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  final Message message;
  const MessageBox({
    super.key,
    required this.message,
  });

  Widget getMessage() {
    if (message.type == MessageType.user) {
      return UserMessageBox(message: message);
    } else if (message.type == MessageType.ai) {
      return AppMessageBox(message: message);
    }
    return const EmptyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: getMessage(),
    );
  }
}

class AppMessageBox extends MessageBox {
  const AppMessageBox({
    super.key,
    required super.message,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.85,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            color: theme.colorScheme.tertiary,
          ),
          child: Text(
            message.content,
            style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class UserMessageBox extends MessageBox {
  const UserMessageBox({
    super.key,
    required super.message,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Uint8List? image;
    if (message.image != null) {
      image = base64.decode(message.image!);
    }

    return Row(
      children: [
        const Spacer(),
        Container(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.85,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            color: theme.colorScheme.secondaryContainer,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (image != null) ...[
                GestureDetector(
                  onTap: () {
                    NavigationService.openImageDisplayDialog(
                      base64String: image,
                    );
                  },
                  child: Image.memory(
                    image,
                  ),
                ),
              ],
              Text(
                message.content,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
