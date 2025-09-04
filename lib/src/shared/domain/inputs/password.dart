import 'package:equatable/equatable.dart';

enum PasswordValidationError { empty, length }

class Password extends Equatable {
  final String value;

  final PasswordValidationError? error;

  const Password._(this.value, this.error);

  const Password.pure() : this._('', null);

  bool get isValid => error == null;

  factory Password.dirty(String value) {
    if (value.trim().isEmpty) {
      return Password._(value, PasswordValidationError.empty);
    }

    if (value.trim().length < 3) {
      return Password._(value, PasswordValidationError.length);
    }
    return Password._(value, null);
  }

  String? get errorMessage {
    if (isValid) return null;
    if (PasswordValidationError.empty == error) return 'Campo requerido';
    if (PasswordValidationError.length == error) return 'Password no válido';
    return null;
  }

  @override
  List<Object?> get props => [value, error];
}
