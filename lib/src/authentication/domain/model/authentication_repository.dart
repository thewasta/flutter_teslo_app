import 'package:teslo_app/src/authentication/domain/model/user.dart';
import 'package:teslo_app/src/shared/domain/inputs/email.dart';
import 'package:teslo_app/src/shared/domain/inputs/password.dart';

abstract class AuthenticationRepository {
  Future<User> login(Email email, Password password);

  Future<void> logout();
}
