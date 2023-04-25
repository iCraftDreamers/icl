import 'dart:typed_data';

import 'package:icl/utils/auth/account.dart';
import 'package:icl/utils/auth/offline/skin.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';

class OfflineAccount extends Account {
  final String _username;
  String? _uuid;
  Skin? _skin;

  OfflineAccount(this._username);

  Skin get skin =>
      _skin ??
      (uuid.hashCode & 1 == 1
          ? const Skin(SkinType.alex)
          : const Skin(SkinType.steve));

  @override
  String get username => _username;

  @override
  String get uuid => _uuid ?? const Uuid().v5(Uuid.NAMESPACE_OID, username);

  @override
  Future<Uint8List?> get avatar async {
    final source = decodePng(await skin.u8l);
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
