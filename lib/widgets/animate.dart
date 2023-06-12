import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';

void showcustomsnackbar(String messages) {
  Get.showSnackbar(GetSnackBar(
    message: messages,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 12.5,
    animationDuration: const Duration(milliseconds: 450),
    duration: const Duration(seconds: 1),
    margin: const EdgeInsets.only(bottom: 15),
    maxWidth: 400,
    backgroundColor: Theme.of(Get.context!).colorScheme.primary,
    icon: Icon(Icons.check),
  ));
}
