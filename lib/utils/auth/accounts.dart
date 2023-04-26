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
}
