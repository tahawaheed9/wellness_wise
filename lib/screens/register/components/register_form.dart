import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/dialogs/confirm_registration_dialog.dart';
import '/components/dialogs/error_dialog.dart';
import '/services/auth/auth_exceptions.dart';
import '../../../components/text_button.dart';
import '../../../services/auth/bloc/auth_state.dart';
import '/services/auth/bloc/auth_event.dart';
import '../../../components/primary_button.dart';
import '../../../services/auth/bloc/auth_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();

  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _age;
  late final String? _gender;

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is InvalidCredentialAuthException) {
            await showErrorDialog(context, 'Invalid Credentials');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Email address is badly formatted.');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email address is already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Form(
        key: _registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Username Field...
              TextFormField(
                controller: _username,
                autofocus: true,
                keyboardType: TextInputType.name,
                validator: _validateForm,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30.0),

              // Email Address Field...
              TextFormField(
                controller: _email,
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

              const SizedBox(height: 30.0),

              // Password Field...
              TextFormField(
                controller: _password,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.text,
                obscureText: _isObscureText,
                validator: _validateForm,
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

              // Age & Gender Fields...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Age Field...
                  Expanded(
                    child: TextFormField(
                      controller: _age,
                      readOnly: true,
                      onTap: () => _pickDateOfBirth(context),
                      validator: _validateForm,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        labelText: 'Age',
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
                      validator: _validateForm,
                      decoration: InputDecoration(
                        prefixIcon: _selectedValue == null
                            ? const Icon(Icons.person_outline)
                            : _selectedValue == 'Male'
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
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
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
                onPressed: () async {
                  if (_registerFormKey.currentState!.validate()) {
                    final shouldRegister =
                        await showConfirmRegistrationDialog(context);

                    if (shouldRegister) {
                      final String username = _username.text;
                      final String email = _email.text;
                      final String password = _password.text;
                      final int age = int.parse(_age.text);
                      final String gender = _gender.toString();
                      final DateTime createdOn = DateTime.now();
                      if (context.mounted) {
                        context.read<AuthBloc>().add(
                              AuthEventRegister(
                                username,
                                email,
                                password,
                                age,
                                gender,
                                createdOn,
                              ),
                            );
                      }
                    }
                  }
                },
              ),
              const SizedBox(height: 30.0),

              // If user is registered, navigate to login screen...
              MyTextButton(
                title: 'Already have an account?',
                onTap: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
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

  _pickDateOfBirth(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        _calculateAge(pickedDate);
      }
    });
  }

  _calculateAge(DateTime date) {
    DateTime now = DateTime.now();
    Duration age = now.difference(date);
    int years = age.inDays ~/ 365;
    setState(() {
      _age.text = years.toString();
    });
  }
}
