import 'package:capp_flutter/models/popup.dart';
import 'package:capp_flutter/widgets/expanded_button.dart';
import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:get/get.dart';

class PopupBox extends StatelessWidget {
  final Popup popup;
  const PopupBox({
    super.key,
    required this.popup,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: theme.colorScheme.primary,
        ),
        margin: EdgeInsets.all(20.w),
        padding: EdgeInsets.all(12.w),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (popup.icon != null) ...[
              popup.icon!,
              SizedBox(height: 8.h),
            ],
            if (popup.title != null) ...[
              Text(
                popup.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
            if (popup.description != null) ...[
              SizedBox(height: 8.h),
              Text(
                popup.description!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
            SizedBox(height: 20.h),
            if (popup.confirmLabel != null) ...[
              ExpandedButton(
                label: popup.confirmLabel!,
                onTap: () => Get.back(result: 1),
                labelStyle: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 10.w),
            ],
            if (popup.rejectLabel != null) ...[
              ExpandedButton(
                label: popup.rejectLabel!,
                onTap: () => Get.back(result: 0),
                labelStyle: theme.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
