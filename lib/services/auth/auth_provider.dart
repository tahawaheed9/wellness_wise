import 'package:wellness_wise/services/auth/auth_user.dart';

abstract class AuthProvider {
  // Initializing the firebase instance...
  Future<void> initialize();

  // Getting the current user...
  AuthUser? get currentUser;

  // Creating a user...
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  // Logging in the user...
  Future<AuthUser> loginUser({
    required String email,
    required String password,
  });

  // Reset Password...
  Future<void> sendResetPassword({required String toEmail});

  // Logout User...
  Future<void> logoutUser();
}
