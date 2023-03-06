import 'package:get/get.dart';

class AccountManaging {
  static RxList gameAccounts = [].obs;
  static Map<int, String> loginModes = {
    0: '离线登录',
    1: '正版登录',
    2: '外置登录',
  };

  static const String Steve = "assets/images/skins/steve.png";
  static const String Alex = "assets/images/skins/alex.png";
  static String Default = Steve;

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

  static void setCustomSkin(Map user, String skin) {
    if (!user.containsKey("skin")) {
      print("object");
      Map<String, dynamic> theSkin = {"skin": skin};
      user.addAll(theSkin);
    }
    if (user.containsKey("user")) {
      user.update(user, (value) => skin);
    }
  }

  static void setDefaultSkin(Map user) {
    if (user.containsKey("skin")) {
      user.remove("skin");
    }
  }
}
