import 'package:get/get.dart';
import 'package:icl/utils/auth/account.dart';

class Accounts {
  static final accounts = <Account>[].obs;

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
