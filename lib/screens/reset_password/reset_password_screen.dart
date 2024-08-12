import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/dialogs/error_dialog.dart';
import '/services/auth/auth_exceptions.dart';
import '../../services/auth/bloc/auth_state.dart';
import '/services/auth/bloc/auth_event.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '/components/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetPasswordFormKey = GlobalKey<FormState>();
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateResetPassword) {
          if (state.hasSentEmail) {
            _email.clear();
          }
          if (state.exception is InvalidCredentialAuthException) {
            await showErrorDialog(context, 'Email address is not registered');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Email address is badly formatted');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
          leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Please enter your email address and check your mail.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _resetPasswordFormKey,
                  child: TextFormField(
                    controller: _email,
                    autofocus: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              PrimaryButton(
                text: 'Reset Password',
                onPressed: () {
                  if (_resetPasswordFormKey.currentState!.validate()) {
                    final String email = _email.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventResetPassword(email: email));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateForm(value) {
    if (value == null || value.isEmpty) {
      return 'Required.';
    }
    return null;
  }
}
