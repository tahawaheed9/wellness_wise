import 'package:flutter/material.dart';

import '/components/dialogs/error_dialog.dart';
import '/services/auth/auth_exceptions.dart';
import '../../../services/auth/auth_service.dart';
import '/components/text_form_field.dart';
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
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Email Address Field...
            MyTextFormField(
              controller: _email,
              autoCorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              maxLines: 1,
              prefixIcon: const Icon(Icons.email_outlined),
              labelText: 'Email',
              alignLabelWithHint: null,
              hintText: 'abc@example.com',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

            // Password Field...
            MyTextFormField(
              controller: _password,
              autoCorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.text,
              obscureText: _isObscureText,
              maxLines: 1,
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: 'Password',
              alignLabelWithHint: null,
              hintText: 'Example123',
              suffixText: null,
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
            const SizedBox(height: 30.0),

            // Login Button...
            PrimaryButton(
              text: 'Login',
              onPressed: () {
                _loginUser();
              },
            ),
          ],
        ),
      ),
    );
  }

  _loginUser() async {
    final String email = _email.text;
    final String password = _password.text;
    try {
      await AuthService.firebase().loginUser(
        email: email,
        password: password,
      );
    } on UserNotLoggedInAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'User not found.');
    } on InvalidCredentialAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Invalid Credential');
    } on InvalidEmailAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Invalid Email or Email Badly Formatted.');
    } on TooManyRequestsAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Too many tries. Please try again later.');
    } on GenericAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Authentication Error Occurred.');
    }
  }
}
