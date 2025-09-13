import 'package:equatable/equatable.dart';

enum PasswordValidationError { empty, invalidFormat }

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

    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$');
    if (!regex.hasMatch(value)) {
      return Password._(value, PasswordValidationError.invalidFormat);
    }
    return Password._(value, null);
  }

  String? get errorMessage {
    if (isValid) return null;
    if (PasswordValidationError.empty == error) return 'Campo requerido';
    if (PasswordValidationError.invalidFormat == error) return 'Password no válido';
    return null;
  }

  @override
  List<Object?> get props => [value, error];
}
