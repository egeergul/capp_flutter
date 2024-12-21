import 'dart:convert';
import 'dart:typed_data';
import 'package:capp_flutter/constants/app_lotties.dart';
import 'package:capp_flutter/helpers/color_helper.dart';
import 'package:capp_flutter/models/message.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/themes/markdown_styles.dart';
import 'package:capp_flutter/widgets/widgets.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown/markdown.dart' as md;

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
    } else if (message.type == MessageType.appTyping) {
      return const TypingMessageBox();
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

class AppMessageBox extends StatefulWidget {
  const AppMessageBox({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  AppMessageBoxState createState() => AppMessageBoxState();
}

class AppMessageBoxState extends State<AppMessageBox> {
  bool showColorPaletteDetails = false;

  void toggleShowColorPaletteDetails() {
    setState(() {
      showColorPaletteDetails = !showColorPaletteDetails;
    });
  }

  List<Widget> _colorPaletteBox({required ThemeData theme}) {
    if (widget.message.metaData != null &&
        widget.message.metaData!["colorPalette"] != null) {
      if (showColorPaletteDetails) {
        return [
          ColorPalettePreviewView(
            colors: widget.message.metaData!["colorPalette"],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: toggleShowColorPaletteDetails,
            child: Text(
              "Show Details",
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ];
      } else {
        return [
          ColorPaletteDetailedView(
            colors: widget.message.metaData!["colorPalette"],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: toggleShowColorPaletteDetails,
            child: Text(
              "Hide Details",
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ];
      }
    }

    return [];
  }

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
          child: Column(
            children: [
              // Show ColorPalettePreview if exists
              ..._colorPaletteBox(theme: theme),

              MarkdownText(
                text: widget.message.content,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ],
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
              MarkdownText(
                text: message.content,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MarkdownText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const MarkdownText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MarkdownBody(
          selectable: false,
          data: text,
          styleSheet: MarkdownStyles.getMarkdownStyleFrom(style),
          extensionSet: md.ExtensionSet(
            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
            <md.InlineSyntax>[
              md.EmojiSyntax(),
              ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
            ],
          ),
        );
      },
    );
  }
}

class TypingMessageBox extends StatelessWidget {
  const TypingMessageBox({super.key});

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
          child: Lottie.asset(AppLotties.typingDots, height: 20.h),
        ),
        const Spacer(),
      ],
    );
  }
}
