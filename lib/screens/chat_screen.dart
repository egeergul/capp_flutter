import 'package:capp_flutter/controllers/controllers.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/message.dart';
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
        title: GestureDetector(onTap: () {}, child: const Text('Chat Screen')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                itemCount: controller.chat.value.messages.length + 1,
                itemBuilder: (context, index) {
                  // The last item is reserved for typing messae
                  if (index == 0) {
                    if (controller.chat.value.status == ChatStatus.waiting ||
                        controller.chat.value.status == ChatStatus.processing) {
                      return const TypingMessageBox()
                          .marginSymmetric(horizontal: 20.w);
                    }
                    return const EmptyWidget();
                  }

                  Message message = controller.chat.value
                      .messages[controller.chat.value.messages.length - index];

                  return MessageBox(message: message);
                },
              ),
            ),
          ),
          Obx(
            () => InputField(
              focusNode: controller.focusNode,
              hasFocus: controller.hasFocus.value,
              textController: controller.textController,
              typedText: controller.typedText,
              sendButtonDisabled: controller.typedText.isEmpty,
              onTapSendButton: controller.onTapSendButton,
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final FocusNode focusNode;
  final bool hasFocus;
  final TextEditingController textController;
  final bool sendButtonDisabled;
  final RxString typedText;
  final Function onTapSendButton;

  const InputField({
    required this.focusNode,
    required this.hasFocus,
    required this.textController,
    required this.sendButtonDisabled,
    required this.typedText,
    required this.onTapSendButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.secondary,
      padding:
          EdgeInsets.fromLTRB(20.w, 8.h, 8.w, focusNode.hasFocus ? 8.h : 30.h),
      constraints: const BoxConstraints(minHeight: 48), // Minimum height
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey[200],
              ),
              child: TextField(
                maxLines: 4,
                minLines: 1,
                focusNode: focusNode,
                controller: textController,
                onChanged: (value) => typedText.value = value,
                onTapOutside: (event) => focusNode.unfocus(),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8), // Add space between TextField and Button
          // Send Button
          SendButton(disabled: sendButtonDisabled, onTap: onTapSendButton),
        ],
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final bool disabled;
  final Function onTap;
  const SendButton({
    this.disabled = true,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: GestureDetector(
        onTap: () => (disabled ? () {} : onTap)(),
        child: Container(
          height: 36.h,
          width: 36.w,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 4.w),
                Icon(
                  Icons.send,
                  size: 20.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
