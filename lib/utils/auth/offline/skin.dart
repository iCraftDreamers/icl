import 'dart:io';

import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class DefaultSkin {
  String? uuid;
  DefaultSkin({this.uuid});
  Skin skin() {
    //TODO: load default from config file
    return uuid == null ? const Skin(SkinType.steve) : detectUUID();
  }

  Skin detectUUID() {
    return (uuid.hashCode & 1) == 1
        ? const Skin(SkinType.alex)
        : const Skin(SkinType.steve);
  }
}

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

  Future<Uint8List> get u8l async {
    final Uint8List u8l;
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
    }
    return u8l;
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
