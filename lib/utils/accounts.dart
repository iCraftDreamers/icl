import 'package:get/get.dart';

import '../controllers/accounts.dart';

class AccountManaging {
  static RxList gameAccounts = [].obs;
  static Map<int, String> loginModes = {
    0: '离线登录',
    1: '正版登录',
    2: '外置登录',
  };

  static void addAccount(String? username, String? password) {
    final c = Get.put(AccountsController());
    switch (c.loginMode.value) {
      case 0:
        gameAccounts.add(
          {"loginmode": c.loginMode.value, "username": username},
        );
        break;
      case 1:
        // users.add([c.loginMode.value, c.loginUsername]);
        break;
      case 2:
        // users.add([c.loginMode.value, c.loginUsername, c.loginPassword]);
        break;
      default:
        gameAccounts.add(
          {
            "loginmode": c.loginMode.value,
            "username": username,
            "password": password
          },
        );
        break;
    }
  }

  static void removeAccount(user) {
    gameAccounts.remove(user);
  }
}
