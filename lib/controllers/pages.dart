import 'package:get/get.dart';

class PagesController extends GetxController {
  RxInt current = 0.obs;

  void updateCurrent(RxInt i) {
    current = i;
    update();
  }
}
