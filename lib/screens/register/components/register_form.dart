import 'package:flutter/material.dart';

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
  String? gender;

  bool isObscureText = true;
  String? _selectedValue;

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
            TextFormField(
              controller: username,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Username',
                hintText: 'Abc',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Email Address Field...
            TextFormField(
              controller: email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                hintText: 'abc@example.com',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Password Field...
            TextFormField(
              controller: password,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: isObscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outlined),
                labelText: 'Password',
                hintText: 'Example123',
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
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Age & Gender Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Age Field...
                Expanded(
                  child: TextFormField(
                    controller: age,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                      labelText: 'Age',
                      hintText: '0',
                      border: OutlineInputBorder(),
                    ),
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
                        gender = value;
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
