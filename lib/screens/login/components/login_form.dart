import 'package:flutter/material.dart';

import '/components/text_form_field.dart';
import '/components/primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isObscureText = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Email Address Field...
            MyTextFormField(
              controller: email,
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
              controller: password,
              autoCorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.text,
              obscureText: isObscureText,
              maxLines: 1,
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: 'Password',
              alignLabelWithHint: null,
              hintText: 'Example123',
              suffixText: null,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                child: isObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: 30.0),

            // Login Button...
            PrimaryButton(
              text: 'Login',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
