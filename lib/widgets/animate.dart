import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';

void showcustomsnackbar(String message) {
  Get.showSnackbar(GetSnackBar(
    message: message,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 12.5,
    animationDuration: const Duration(milliseconds: 450),
    duration: const Duration(seconds: 1),
    margin: const EdgeInsets.only(bottom: 15),
    maxWidth: 450,
  ));
}
