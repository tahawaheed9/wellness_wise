import 'package:flutter/material.dart';

import '/services/auth/firebase_auth_services.dart';
import '/components/text_form_field.dart';
import '../../../components/primary_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _age;
  String? _gender;

  String? _selectedValue;

  bool _isObscureText = true;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _age = TextEditingController();
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Username Field...
            MyTextFormField(
              controller: _username,
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

            // Age & Gender Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Age Field...
                Expanded(
                  child: MyTextFormField(
                    controller: _age,
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
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedValue,
                    hint: const Text('Gender'),
                    alignment: Alignment.center,
                    decoration: InputDecoration(
                      prefixIcon: _selectedValue == null
                          ? const Icon(Icons.person_outline)
                          : _selectedValue == 'male'
                              ? const Icon(Icons.male)
                              : const Icon(Icons.female),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                        _gender = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // Register Button...
            PrimaryButton(
              text: 'Register',
              onPressed: () {
                final String email = _email.text;
                final String password = _password.text;
                createUser(
                  context: context,
                  email: email,
                  password: password,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
