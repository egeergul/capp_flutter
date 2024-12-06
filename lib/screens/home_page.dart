import 'package:capp_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());
    return Container(
      padding: EdgeInsets.all(20.h),
      child: Column(
        children: [
          _ActionOptionButton(
            title: "Image Analyser",
            description:
                "Add an image and get a detailed analysis of the used colors from",
            onTap: homePageController.onTapImageAnalyser,
          ),
          SizedBox(height: 10.h),
          _ActionOptionButton(
            title: "Color Palette Detector",
            description: "Add an image and get the used color palette of it",
            onTap: homePageController.onTapColorPaletteDetector,
          ),
          SizedBox(height: 10.h),
          _ActionOptionButton(
            title: "Color Palette Generator",
            description: "Create custom color palettes according to your needs",
            onTap: homePageController.onTapColorPaletteGenerator,
          ),
        ],
      ),
    );
  }
}

class _ActionOptionButton extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ActionOptionButton({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 75.h,
        ),
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: theme.colorScheme.primaryContainer,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            Text(
              description,
              style: theme.textTheme.labelMedium!.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
