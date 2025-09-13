import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/src/authentication/domain/model/authentication_repository.dart';
import 'package:teslo_app/src/authentication/domain/model/user.dart';
import 'package:teslo_app/src/authentication/infrastructure/provider/api/api_authentication_repository.dart';
import 'package:teslo_app/src/shared/domain/inputs.dart';
import 'package:teslo_app/src/shared/infrastructure/exception/infrastructure_exception.dart';
import 'package:teslo_app/src/shared/infrastructure/provider/http/dio_http_client.dart';
import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/src/shared/infrastructure/provider/local_storage/shared_preferences_device_storage_repository.dart';

final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig(baseUrl: Environment.apiUrl);
});

final httpClientProvider = Provider<HttpClient>((ref) {
  final config = ref.watch(apiConfigProvider);
  return DioHttpClient(config: config);
});

final apiAuthenticationRepositoryProvider = Provider<AuthenticationRepository>((
  ref,
) {
  final client = ref.watch(httpClientProvider);
  return ApiAuthenticationRepository(client: client);
});

final sharedPreferencesRepositoryProvider =
    Provider<SharedPreferencesDeviceStorageRepository>((ref) {
      return SharedPreferencesDeviceStorageRepository();
    });

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
      final authRepo = ref.watch(apiAuthenticationRepositoryProvider);
      final sharedRepo = ref.watch(sharedPreferencesRepositoryProvider);
      return AuthenticationNotifier(authRepo, sharedRepo);
    });

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final AuthenticationRepository _authRepo;
  final SharedPreferencesDeviceStorageRepository
  _sharedPreferencesDeviceStorageRepository;

  AuthenticationNotifier(
    this._authRepo,
    this._sharedPreferencesDeviceStorageRepository,
  ) : super(AuthenticationState());

  Future<void> login(Email email, Password password) async {
    try {
      final user = await _authRepo.login(email, password);
      await _sharedPreferencesDeviceStorageRepository.setValue(
        'token',
        user.token,
      );
      state = state.copyWith(user: user, status: AuthStatus.authenticated);
    } on InfrastructureException catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Ha ocurrido un error inesperado');
    }
  }

  Future<void> logout([String? errorMessage]) async {
    await _sharedPreferencesDeviceStorageRepository.removeKey('token');
    state = state.copyWith(
      user: null,
      status: AuthStatus.nonAuthenticated,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { checking, authenticated, nonAuthenticated }

class AuthenticationState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;

  AuthenticationState({
    this.status = AuthStatus.nonAuthenticated,
    this.user,
    this.errorMessage = '',
  });

  AuthenticationState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) => AuthenticationState(
    status: status ?? this.status,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
