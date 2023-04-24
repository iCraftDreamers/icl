import 'package:flutter/services.dart';
import 'package:image/image.dart';

abstract class Account {
  String get username;
  String get uuid;
  Future<Uint8List> get u8l;
  const Account();

  Future<Uint8List?> get avatar async {
    final source = decodePng(await u8l);
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

  @override
  String toString() => "username: $username, uuid: $uuid";
}
