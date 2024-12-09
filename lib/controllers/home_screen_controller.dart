import 'package:get/state_manager.dart';

class HomeScreenController extends GetxController {
  final RxInt currentPageIndex = 1.obs;

  void onTabTapped(int index) {
    currentPageIndex.value = index;
  }
}
