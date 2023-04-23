abstract class Account {
  String get username;
  String get uuid;

  const Account();

  @override
  String toString() => "username: $username, uuid: $uuid";
}
