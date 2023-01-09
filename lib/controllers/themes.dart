import 'package:get/get.dart';

class ThemesController extends GetxController {
  RxBool adaptive = false.obs;

  void updateState(var state) {
    adaptive = state;
    update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
  }
}
