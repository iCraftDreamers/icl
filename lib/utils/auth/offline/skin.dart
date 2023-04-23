import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';

class Skin {
  final SkinType type;
  final TextureModel? textureModel;
  final String? localSkinPath;
  final String? localCapePath;

  const Skin(
    this.type, {
    this.textureModel,
    this.localSkinPath,
    this.localCapePath,
  });

  Future<Uint8List?> get avatar async {
    late final Uint8List u8l;
    switch (type) {
      case SkinType.steve:
        u8l = (await rootBundle.load("assets/images/skins/steve.png"))
            .buffer
            .asUint8List();
        break;
      case SkinType.alex:
        u8l = (await rootBundle.load("assets/images/skins/alex.png"))
            .buffer
            .asUint8List();
        break;
      case SkinType.custom:
        u8l = File(localSkinPath!).readAsBytesSync();
        break;
      default:
        return null;
    }
    final source = decodePng(u8l);
    final wratio = source!.width ~/ 64;
    final lratio =
        (source.height == source.width) ? wratio : source.height ~/ 32;
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
    return encodePng(head);
  }
}

enum SkinType {
  steve,
  alex,
  custom;
}

enum TextureModel {
  steve,
  alex;

  static TextureModel detectUUID(Uuid uuid) {
    return (uuid.hashCode & 1) == 1 ? alex : steve;
  }
}
