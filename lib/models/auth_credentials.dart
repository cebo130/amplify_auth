// 1
abstract class AuthCredentials {
  late final String username;
  late final String password;

  AuthCredentials({required this.username, required this.password});
}

// 2
class LoginCredentials extends AuthCredentials {
  LoginCredentials({required String username, required String password})
      : super(username: username, password: password);
}

// 3
class SignUpCredentials extends AuthCredentials {
  final String email;
  final String phonenumber;

  SignUpCredentials(
      {required String username,
        required this.phonenumber,
        required String password,
        required this.email})
      : super(username: username, password: password);
}

