import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/text_button.dart';
import '/components/dialogs/error_dialog.dart';
import '/services/auth/auth_exceptions.dart';
import '../../../services/auth/bloc/auth_state.dart';
import '/services/auth/bloc/auth_event.dart';
import '../../../services/auth/bloc/auth_bloc.dart';
import '/components/primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool _isObscureText = true;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is InvalidCredentialAuthException) {
            await showErrorDialog(context, 'Invalid Credentials');
          } else if (state.exception is TooManyRequestsAuthException) {
            await showErrorDialog(
                context, 'Too many tries. Please try again later.');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Email address is badly formatted');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Email Address Field...
              TextFormField(
                controller: _email,
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30.0),

              // Password Field...
              TextFormField(
                controller: _password,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                obscureText: _isObscureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: Tooltip(
                    message: _isObscureText ? 'Show Password' : 'Hide Password',
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscureText = !_isObscureText;
                        });
                      },
                      child: _isObscureText
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Login Button...
              PrimaryButton(
                text: 'Login',
                onPressed: () {
                  final String email = _email.text;
                  final String password = _password.text;
                  context.read<AuthBloc>().add(AuthEventLogin(email, password));
                },
              ),
              const SizedBox(height: 30.0),

              // Reset Password Button...
              MyTextButton(
                title: 'Reset Password',
                onTap: () {
                  context.read<AuthBloc>().add(const AuthEventResetPassword());
                },
              ),
              const SizedBox(height: 75.0),

              // Create An Account...
              MyTextButton(
                title: 'Create an account',
                onTap: () {
                  context.read<AuthBloc>().add(const AuthEventShouldRegister());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
