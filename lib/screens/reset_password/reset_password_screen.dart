import 'package:flutter/material.dart';

import '/components/dialogs/error_dialog.dart';
import '/services/auth/auth_exceptions.dart';
import '/services/auth/auth_service.dart';
import '/components/text_form_field.dart';
import '/components/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50.0),
            Text(
              'Please enter your email address.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextFormField(
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
            ),
            const SizedBox(height: 50.0),
            PrimaryButton(
              text: 'Reset Password',
              onPressed: () {
                _sendResetPassword();
              },
            ),
          ],
        ),
      ),
    );
  }

  _sendResetPassword() async {
    final String toEmail = _email.text;
    try {
      await AuthService.firebase().sendResetPassword(toEmail: toEmail);
    } on InvalidCredentialAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Invalid Credential.');
    } on InvalidEmailAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Invalid Credential.');
    } on GenericAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Authentication Error Occurred.');
    }
  }
}
