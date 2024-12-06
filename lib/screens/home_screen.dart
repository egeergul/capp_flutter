import 'package:capp_flutter/controllers/controllers.dart';
import 'package:capp_flutter/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final HomeScreenController controller = Get.put(HomeScreenController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text('CAPP'),
        ),
        body: IndexedStack(
          index: controller.currentPageIndex.value,
          children: const [
            DiscoverPage(),
            HomePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: theme.colorScheme.primary,
          selectedItemColor: theme.colorScheme.onPrimary,
          currentIndex: controller.currentPageIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: controller.onTabTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
