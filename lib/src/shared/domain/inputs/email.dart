import 'package:equatable/equatable.dart';

enum EmailValidationError { empty, invalidFormat }

class Email extends Equatable {
  final String value;

  final EmailValidationError? error;

  const Email._(this.value, this.error);

  const Email.pure() : this._('', null);

  bool get isValid => error == null;

  factory Email.dirty(String value) {
    if (value.trim().isEmpty) {
      return Email._(value, EmailValidationError.empty);
    }

    final emailRegex = RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return Email._(value, EmailValidationError.invalidFormat);
    }
    return Email._(value, null);
  }

  String? get errorMessage {
    if (isValid) return null;
    if (EmailValidationError.empty == error) return 'Campo requerido';
    if (EmailValidationError.invalidFormat == error) return 'Email no válido';
    return null;
  }

  @override
  List<Object?> get props => [value, error];
}
