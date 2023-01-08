import 'package:get/get.dart';

class PagesController extends GetxController {
  late RxString indexName;
  late RxInt current;

  late RxList<String> routeName = [
    "/home",
    "/appearance",
    "/setting",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    current = 0.obs;
  }

  void updateCurrent(RxInt i) {
    current = i;
    update();
  }
}
