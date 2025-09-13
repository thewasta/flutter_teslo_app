import 'package:teslo_app/src/authentication/domain/model/user.dart';
import 'package:teslo_app/src/authentication/domain/model/authentication_repository.dart';
import 'package:teslo_app/src/shared/domain/inputs.dart';
import 'package:teslo_app/src/shared/infrastructure/provider/dio_http_client.dart';

class ApiAuthenticationRepository implements AuthenticationRepository {
  final HttpClient _client;

  ApiAuthenticationRepository({required HttpClient client}) : _client = client;

  @override
  Future<User> login(Email email, Password password) async {
    final res = await _client.post('/auth/login', {
      'email': email.value,
      'password': password.value,
    });
    return User.fromJson(res);
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
