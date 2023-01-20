import 'package:get/get.dart';

class ThemesController extends GetxController {
  RxInt thememode = 1.obs;

  void updateThemeMode(int current) {
    thememode = current.obs;
    update();
  }
}
