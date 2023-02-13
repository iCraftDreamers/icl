import 'package:get/get.dart';

class AccountsManaging extends GetxController {
  static List<Map> gameAccounts = [];
  void add(Map user) {
    gameAccounts.add(user);
  }

  void delete(Map user) {
    gameAccounts.remove(user);
  }
}
