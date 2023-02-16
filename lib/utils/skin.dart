import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';

class Skin {
  static Uint8List toAvatar(file) {
    final source = decodePng(File(file).readAsBytesSync());
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
