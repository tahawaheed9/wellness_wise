import 'package:flutter/material.dart';

import '/screens/register/components/register_form.dart';
import '/components/primary_button.dart';
import '/controller/screen_navigation_controller.dart';
import '/components/screen_heading.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50.0),
                const ScreenHeading(
                  icon: Icons.person_outline,
                  headingText: 'Register',
                ),
                const SizedBox(height: 50.0),

                // Register Form...
                const RegisterForm(),
                const SizedBox(height: 30.0),

                // If user is registered, navigate to login screen...
                PrimaryButton(
                  text: 'Have an account?',
                  onPressed: () {
                    pushLoginScreen(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
