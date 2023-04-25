import 'dart:typed_data';

import 'package:icl/utils/auth/account.dart';
import 'package:icl/utils/auth/offline/skin.dart';

class OfflineAccount extends Account {
  final String _username;
  final String _uuid;
  final Skin? _skin;

  const OfflineAccount(
    this._username,
    this._uuid,
    this._skin,
  );

  @override
  String get username => _username;

  @override
  String get uuid => _uuid;

  Skin get skin => _skin ?? DefaultSkin(uuid: uuid).skin();

  @override
  Future<Uint8List> get u8l => _skin!.u8l;
}
