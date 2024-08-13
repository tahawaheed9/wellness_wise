import '../auth/auth_user.dart';
import '../auth/auth_provider.dart';
import '../auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> createUser({
    required String username,
    required String email,
    required String password,
    required int age,
    required String gender,
  }) =>
      provider.createUser(
        username: username,
        email: email,
        password: password,
        age: age,
        gender: gender,
      );

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<AuthUser> loginUser({
    required String email,
    required String password,
  }) =>
      provider.loginUser(
        email: email,
        password: password,
      );

  @override
  Future<void> sendResetPassword({required String toEmail}) =>
      provider.sendResetPassword(toEmail: toEmail);

  @override
  Future<void> logoutUser() => provider.logoutUser();
}
