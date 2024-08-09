import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

import '../../../services/auth/firebase_auth_services.dart';
import '../../otp_verification/otp_verification_screen.dart';
import '/controller/screen_navigation_controller.dart';
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
              onPressed: () async {
                // Trying to login the user...
                if (context.mounted) {
                  final email = _email.text;
                  final password = _password.text;
                  await loginUser(
                    context: context,
                    email: email,
                    password: password,
                  );

                  // If user is logged in, send OTP Verification...
                  if (context.mounted) {
                    EmailOTP.sendOTP(email: email);
                    // Wait for the response...
                    bool isUserAuthorized = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OTPVerificationScreen(email: email),
                      ),
                    );
                    final user = currentUser;
                    // If user exists and is authorized, push HomeScreen...
                    if (user != null && isUserAuthorized) {
                      if (context.mounted) {
                        pushHomeScreen(context);
                      }
                    } else {
                      if (context.mounted) {
                        pushLoginScreen(context);
                      }
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
