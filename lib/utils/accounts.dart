import 'package:get/get.dart';

class AccountManaging {
  static RxList gameAccounts = [].obs;
  static Map<int, String> loginModes = {
    0: '离线登录',
    1: '正版登录',
    2: '外置登录',
  };

  static String Steve = "assets/images/skins/steve.png";
  static String Alex = "assets/images/skins/alex.png";
  static String defaultSkin = Steve;

  static void add(String? username, String? password, loginMode) {
    switch (0) {
      case 0:
        gameAccounts.add(
          {
            "loginmode": loginMode,
            "username": username,
          },
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
            "loginmode": loginMode,
            "username": username,
          },
        );
        break;
    }
  }

  static void removeAccount(user) {
    gameAccounts.remove(user);
  }
}
