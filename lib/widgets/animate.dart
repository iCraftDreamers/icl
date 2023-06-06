import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';

void showcustomsnackbar(String message) {
  Get.showSnackbar(GetBar(
    message: message,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 12.5,
    animationDuration: Duration(milliseconds: 400),
    duration: Duration(seconds: 1),
    margin: EdgeInsets.only(bottom: 15),
    maxWidth: 450,
  ));
}
