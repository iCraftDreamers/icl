import 'dart:typed_data';

import 'package:icl/utils/auth/account.dart';

class MicrosoftAccount extends Account {
  final String _username;
  final String _uuid;

  const MicrosoftAccount(this._username, this._uuid);

  @override
  String get username => _username;

  @override
  String get uuid => _uuid;

  @override
  // TODO: implement avatar
  Future<Uint8List?> get avatar => throw UnimplementedError();
}
