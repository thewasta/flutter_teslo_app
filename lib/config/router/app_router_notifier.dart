import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:teslo_app/src/authentication/presentation/provider/authentication_provider.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authenticationProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthenticationNotifier _authenticationNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._authenticationNotifier) {
    _authenticationNotifier.addListener((state) {
      authStatus = state.status;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
