import 'package:get/get.dart';
import 'package:icl/utils/auth/account.dart';
import 'package:uuid/uuid.dart';

import 'auth/offline/offline_account.dart';

class Accounts {
  static final list = <Account>[].obs;
  void addOffine(String username) {
    Accounts.list.add(
      OfflineAccount(
          username, const Uuid().v5(Uuid.NAMESPACE_OID, username), null),
    );
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
