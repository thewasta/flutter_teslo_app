import 'package:equatable/equatable.dart';
import 'package:teslo_app/src/shared/domain/inputs.dart';

class User extends Equatable {
  final String id;
  final Email email;
  final List<String> roles;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.roles,
    required this.token,
  });

  factory User.fromJson(json) {
    return User(
      id: json['id'],
      email: Email.dirty(json['email']),
      roles: List<String>.from(json["roles"]).toList(),
      token: json["token"],
    );
  }

  @override
  List<Object?> get props => [];

  bool get isAdmin {
    return roles.contains('admin');
  }
}
