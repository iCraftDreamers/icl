import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';

void showcustomsnackbar(String messages) {
  Get.showSnackbar(GetSnackBar(
    message: messages,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 12.5,
    animationDuration: const Duration(milliseconds: 200),
    duration: const Duration(seconds: 1),
    margin: const EdgeInsets.only(bottom: 10),
    maxWidth: Get.width *0.5,
    backgroundColor: Theme.of(Get.context!).colorScheme.primary,
    icon: const Icon(Icons.check),
  ));
}
