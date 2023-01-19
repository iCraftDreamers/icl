import 'package:get/get.dart';

class ThemesController extends GetxController {
  RxList<bool> isSelected = [
    true,
    false,
    false,
  ].obs;

  void updateIsSelected(index) {
    isSelected = [
      false,
      false,
      false,
    ].obs;
    isSelected[index] = true;
    update();
  }
}
