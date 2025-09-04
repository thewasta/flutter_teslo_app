import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/src/shared/domain/inputs/email.dart';
import 'package:teslo_app/src/shared/domain/inputs/password.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
      return LoginFormNotifier();
    });

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(const LoginFormState());

  onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(email: email, isValid: isFormValid());
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(password: password, isValid: isFormValid());
  }

  onSubmit() async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
      hasBeenPosted: true,
      email: email,
      password: password,
    );
    if (!state.isValid) return;
  }

  bool isFormValid() {
    return state.email.isValid && state.password.isValid;
  }
}

class LoginFormState extends Equatable {
  final bool isPosting;
  final bool hasBeenPosted;
  final bool isValid;
  final Email email;
  final Password password;

  const LoginFormState({
    this.isPosting = false,
    this.hasBeenPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? hasBeenPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    hasBeenPosted: hasBeenPosted ?? this.hasBeenPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  List<Object?> get props => [
    isPosting,
    hasBeenPosted,
    isValid,
    email,
    password,
  ];
}
