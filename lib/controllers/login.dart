import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var loginMode = 0.obs;
  final loginUsername = TextEditingController();
  final loginPassword = TextEditingController();
}
