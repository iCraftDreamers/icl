import 'package:get/get.dart';

import '/utils/auth/account.dart';

abstract class Accounts {
  static final list = <Account>[].obs;
  static bool add(Account account) {
    if (list.contains(account)) {
      return true;
    }
    Accounts.list.add(account);
    return false;
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
