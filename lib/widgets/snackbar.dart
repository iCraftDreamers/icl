import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar defaultSnackBar(String messages, [Color? borderColor, Icon? icon]) {
  return GetSnackBar(
    message: messages,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 12.5,
    animationDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 1500),
    margin: const EdgeInsets.only(bottom: 10),
    maxWidth: Get.width * 0.5,
    borderColor: borderColor,
    icon: icon,
  );
}

GetSnackBar successSnackBar(String messages) {
  return defaultSnackBar(messages, Colors.lightGreen, const Icon(Icons.check));
}

GetSnackBar warningSnackBar(String messages) {
  return defaultSnackBar(
      messages, Colors.orangeAccent, const Icon(Icons.warning_amber_rounded));
}

GetSnackBar errorSnackBar(String messages) {
  return defaultSnackBar(messages, Colors.red, const Icon(Icons.error_outline));
}
