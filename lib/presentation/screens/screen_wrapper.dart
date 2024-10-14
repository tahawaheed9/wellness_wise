import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/screens/main_screen_wrapper.dart';
import '/data/services/auth/bloc/auth_event.dart';
import '/presentation/screens/login/login_screen.dart';
import '/presentation/screens/verification/email_verification_screen.dart';
import '/presentation/screens/register/register_screen.dart';
import '/presentation/screens/reset_password/reset_password_screen.dart';
import '/data/services/auth/bloc/auth_state.dart';
import '/presentation/components/helpers/loading_screen.dart';
import '/data/services/auth/bloc/auth_bloc.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment...',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const MainScreenWrapper();
        } else if (state is AuthStateNeedsVerification) {
          return const EmailVerificationScreen();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScreen();
        } else if (state is AuthStateRegistering) {
          return const RegisterScreen();
        } else if (state is AuthStateResetPassword) {
          return const ResetPasswordScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
