import 'package:get/get.dart';

class AccountManaging {
  static RxList gameAccounts = [].obs;
  static const Map<int, String> loginModes = {
    0: '离线登录',
    1: '正版登录',
    2: '外置登录',
  };

  static const String Steve = "Steve";
  static const String Alex = "Alex";
  static String Default = Steve;

  static void add(String? username, String? password, int loginMode) {
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

  static void setCustomSkin(Map user, String skin) {
    if (!user.containsKey("skin")) {
      Map<String, String> theSkin = {"skin": skin};
      user.addAll(theSkin);
    }
    if (user.containsKey("skin")) {
      user.update("skin", (value) => skin);
    }
  }

  static void setDefaultSkin(Map user) {
    if (user.containsKey("skin")) {
      user.remove("skin");
    }
  }
}
