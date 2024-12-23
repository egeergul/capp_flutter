import 'package:capp_flutter/controllers/controllers.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    DiscoverPageController controller = Get.put(DiscoverPageController());

    return Obx(
      () => SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              ...controller.tutorials.map(
                (t) => TutorialPreview(
                  map: t,
                  onTap: () => controller.onTapTutorial(t),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class TutorialPreview extends StatelessWidget {
  final Map map;
  final VoidCallback onTap;
  const TutorialPreview({
    super.key,
    required this.map,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 60.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          color: Colors.amber,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              map["title"],
              style: themeData.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Level: ${map["level"]}",
              style: themeData.textTheme.bodyLarge?.copyWith(
                color: Colors.black.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              map["description"],
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: Colors.black.withOpacity(0.7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
