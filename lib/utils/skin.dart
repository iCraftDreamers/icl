import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

class Skin {
  bool isLegal(file) {
    final Image? source = decodePng(file.readAsBytesSync());
    if (source!.width >= 64 &&
        (source.width / source.height == 1 ||
            source.width / source.height == 2) &&
        source.width % source.height == 0 &&
        source.width % 64 == 0) return true;
    return false;
  }
}
