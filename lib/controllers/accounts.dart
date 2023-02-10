import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:icl/utils/accounts.dart';

class AccountsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxInt loginMode = 0.obs;
  TextEditingController loginUsername = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  String? userNameValidator(String value) {
    print("validating...");
    if (value.isEmpty || value.length < 4) {
      return 'Password must be at least 4 characters long.';
    }
    return null;
  }

  void addAccount() {
    final acc = AccountsManaging();
    switch (loginMode.value) {
      case 1:
        // users.add([c.loginMode.value, c.loginUsername]);
        break;
      case 2:
        // users.add([c.loginMode.value, c.loginUsername, c.loginPassword]);
        break;
      default:
        acc.add({"loginMode": loginMode.value, "username": loginUsername.text});
        break;
    }
    print(acc.accounts);
  }
}
