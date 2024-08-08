import 'package:flutter/material.dart';

import '../../services/auth/firebase_auth_services.dart';
import '/components/text_form_field.dart';
import '/components/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final TextEditingController _email;
  bool isResetPasswordSent = false;

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
                final String email = _email.text;
                sendResetPassword(
                  context: context,
                  toEmail: email,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
