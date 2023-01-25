import 'package:get/get.dart';

class HomeController extends GetxController {
  static const List data = [
    {'id': 1, 'name': '离线模式'},
    {'id': 2, 'name': '在线模式'},
    {'id': 3, 'name': 'iCraft通行证'},
  ];
  var loginMode = data[0];

  void updateLoginMode(Object? index) {
    loginMode = index;
    print(loginMode);
    update();
  }
}
