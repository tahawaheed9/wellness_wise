import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// AuthEvent Initialization...
class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

// User Registration Events...
class AuthEventRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final DateTime dateOfBirth;
  final String gender;
  final DateTime createdOn;

  const AuthEventRegister(
    this.username,
    this.email,
    this.password,
    this.dateOfBirth,
    this.gender,
    this.createdOn,
  );
}

// Login Auth Events...
class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin(
    this.email,
    this.password,
  );
}

// Reset Password Events...
class AuthEventResetPassword extends AuthEvent {
  final String? email;

  const AuthEventResetPassword({this.email});
}

// Send Email Verification Events...
class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

// Should user register events...
class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

// Logout Events...
class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
