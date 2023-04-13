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

  Future<Uint8List> toAvatar(file) async {
    late final Uint8List u8l;
    switch (file) {
      case "Steve":
        u8l = (await rootBundle.load("assets/images/skins/steve.png"))
            .buffer
            .asUint8List();
        break;
      case "Alex":
        u8l = (await rootBundle.load("assets/images/skins/alex.png"))
            .buffer
            .asUint8List();
        break;
      default:
        u8l = File(file).readAsBytesSync();
    }
    final source = decodePng(u8l);
    int wratio = source!.width ~/ 64;
    int lratio = (source.height == source.width) ? wratio : source.height ~/ 32;
    final face = copyResize(
        copyCrop(source, x: 8 * wratio, y: 8 * lratio, width: 8, height: 8),
        width: 64,
        height: 64);
    final hair = copyResize(
        copyCrop(source, x: 40 * wratio, y: 8 * lratio, width: 8, height: 8),
        width: 72,
        height: 72);
    final head = Image(width: 72, height: 72, numChannels: 4);
    head.clear(ColorInt8.rgba(0, 0, 0, 0));
    compositeImage(head, face, center: true);
    compositeImage(head, hair, center: true);
    final result = encodePng(head);
    return result;
  }
}
