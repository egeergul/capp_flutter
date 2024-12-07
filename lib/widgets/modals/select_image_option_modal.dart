import 'package:capp_flutter/controllers/controllers.dart';
import 'package:capp_flutter/widgets/modals/modal_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:get/get.dart';

class SelectImageOptionModal extends StatelessWidget {
  const SelectImageOptionModal({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SelectImageOptionModalController controller =
        Get.put(SelectImageOptionModalController());
    return ModalWrapper(
      child: Column(
        children: [
          Text(
            "Pick Image",
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _OptionButton(
                title: "Camera",
                icon: Icons.camera_alt,
                onTap: controller.onTapCamera,
              ),
              SizedBox(width: 20.w),
              _OptionButton(
                title: "Gallery",
                icon: Icons.photo,
                onTap: controller.onTapGallery,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _OptionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: theme.colorScheme.inversePrimary,
          ),
          child: Column(
            children: [
              Icon(icon, color: theme.colorScheme.tertiary),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
