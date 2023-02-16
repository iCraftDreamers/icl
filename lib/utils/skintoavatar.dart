import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';

class Skin {
  static Uint8List toAvatar(file) {
    final source = decodePng(File(file).readAsBytesSync());
    final face = copyResize(copyCrop(source!, x: 8, y: 8, width: 8, height: 8),
        width: 64, height: 64);
    final hair = copyResize(copyCrop(source, x: 40, y: 8, width: 8, height: 8),
        width: 72, height: 72);
    final head = Image(width: 72, height: 72, numChannels: 4);
    head.clear(ColorInt8.rgba(0, 0, 0, 0));
    compositeImage(head, face, center: true);
    compositeImage(head, hair, center: true);
    final result = encodePng(head);
    return result;
  }
}
