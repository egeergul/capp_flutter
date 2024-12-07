import 'package:capp_flutter/constants/constants.dart';
import 'package:capp_flutter/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'firebase_options.dart';
import 'package:capp_flutter/utils/base_imports.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        title: 'CAPP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        initialRoute: Routes.splash,
        getPages: [
          GetPage(
            name: Routes.splash,
            page: () => const SplashScreen(),
          ),
          GetPage(
            name: Routes.home,
            page: () => const HomeScreen(),
          ),
        ],
      ),
    );
  }
}
