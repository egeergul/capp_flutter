import 'package:capp_flutter/controllers/profile_page_controllers.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:get/get.dart';

// TODO: pagination may be added in the future
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.put(ProfilePageController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(
        () {
          return ListView.builder(
            itemCount: controller.chats.length,
            itemBuilder: (context, index) {
              Chat chat = controller.chats[index];

              return _HistoryItem(
                chat: chat,
                onTap: controller.onTap,
                topMargin: index == 0 ? 20.h : null,
                bottomMargin:
                    index == controller.chats.length - 1 ? 20.h : null,
              );
            },
          );
        },
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final Chat chat;
  final Function(Chat) onTap;
  final double? topMargin;
  final double? bottomMargin;

  const _HistoryItem({
    required this.chat,
    required this.onTap,
    this.topMargin,
    this.bottomMargin,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(chat),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        margin:
            EdgeInsets.only(top: topMargin ?? 6.h, bottom: bottomMargin ?? 6.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chat.type.name),
            Text(
              chat.messages.isEmpty ? "" : chat.messages.last.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
