import 'package:capp_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Get.put(SplashScreenController());
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Text(
          "CAPP",
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
