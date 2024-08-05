import 'package:flutter/material.dart';

import '/screens/register/components/drop_down_field.dart';
import '/components/text_form_field.dart';
import '../../../components/primary_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerFormKey = GlobalKey<_RegisterFormState>();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController age = TextEditingController();

  bool _isObscureText = true;

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Username Field...
            MyTextFormField(
              controller: username,
              autoCorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.name,
              obscureText: false,
              maxLines: 1,
              prefixIcon: const Icon(Icons.person_outline),
              labelText: 'Username',
              alignLabelWithHint: null,
              hintText: 'Abc',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

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

            // Age & Gender Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Age Field...
                Expanded(
                  child: MyTextFormField(
                    controller: age,
                    autoCorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    labelText: 'Age',
                    alignLabelWithHint: null,
                    hintText: '0',
                    suffixIcon: null,
                    suffixText: null,
                  ),
                ),
                const SizedBox(width: 30.0),

                // Gender Field...
                const Expanded(
                  child: DropDownField()
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // Register Button...
            PrimaryButton(
              text: 'Register',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
