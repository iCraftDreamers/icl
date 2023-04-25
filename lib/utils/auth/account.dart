import 'dart:typed_data';

abstract class Account {
  String get username;
  String get uuid;

  const Account();

  Future<Uint8List?> get avatar;

  @override
  String toString() => "username: $username, uuid: $uuid";
}
