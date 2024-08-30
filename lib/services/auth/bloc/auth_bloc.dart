import 'package:bloc/bloc.dart';

import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    // Initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));
      }
    });

    // Register
    on<AuthEventRegister>((event, emit) async {
      final username = event.username;
      final email = event.email;
      final password = event.password;
      final age = event.age;
      final gender = event.gender;
      final createdOn = event.createdOn;

      try {
        await provider.createUser(
          username: username,
          email: email,
          password: password,
          age: age,
          gender: gender,
          createdOn: createdOn,
        );

        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification(isLoading: false));
      } on Exception catch (error) {
        emit(AuthStateRegistering(
          exception: error,
          isLoading: false,
        ));
      }
    });

    // Navigating to the register page
    on<AuthEventShouldRegister>((event, emit) async {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: false,
      ));
    });

    // Login
    on<AuthEventLogin>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait. We are trying to log you in.',
        ),
      );
      final email = event.email;
      final password = event.password;

      try {
        final user = await provider.loginUser(
          email: email,
          password: password,
        );
        // Check if the email is verified
        if (!user.isEmailVerified) {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(AuthStateLoggedIn(
            user: user,
            isLoading: false,
          ));
        }
      } on Exception catch (error) {
        emit(
          AuthStateLoggedOut(
            exception: error,
            isLoading: false,
          ),
        );
      }
    });

    // Reset Password
    on<AuthEventResetPassword>((event, emit) async {
      // Navigating to the reset password page
      emit(const AuthStateResetPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: false,
      ));
      final email = event.email;
      // User just navigates to the reset password page
      if (email == null) {
        return;
      }
      // User is requesting a password reset
      emit(
        const AuthStateResetPassword(
          exception: null,
          hasSentEmail: false,
          isLoading: true,
        ),
      );

      bool didSendEmail;
      Exception? exception;

      try {
        await provider.sendResetPassword(toEmail: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (error) {
        didSendEmail = false;
        exception = error;
      }

      emit(
        AuthStateResetPassword(
          exception: exception,
          hasSentEmail: didSendEmail,
          isLoading: false,
        ),
      );
    });

    // Send Email Verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    // Logout
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logoutUser();
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } on Exception catch (error) {
        emit(
          AuthStateLoggedOut(
            exception: error,
            isLoading: false,
          ),
        );
      }
    });
  }
}
