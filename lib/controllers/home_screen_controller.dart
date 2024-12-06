import 'package:get/state_manager.dart';

class HomeScreenController extends GetxController {
  final RxInt currentPageIndex = 0.obs;

  void onTabTapped(int index) {
    print("EGE $index");
    currentPageIndex.value = index;
  }
}
