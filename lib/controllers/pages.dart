import 'package:get/get.dart';

class PagesController extends GetxController {
  RxInt current = 0.obs;

  final RxList<String> routeName = [
    "/home",
    "/appearance",
    "/setting",
  ].obs;

  void updateCurrent(RxInt i) {
    current = i;
    update();
  }
}
