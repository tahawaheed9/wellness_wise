import 'package:flutter/material.dart';

import '/screens/register/components/register_form.dart';
import '/components/screen_heading.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                ScreenHeading(
                  icon: Icons.person_outline,
                  headingText: 'Register',
                ),
                SizedBox(height: 50.0),

                // Register Form...
                RegisterForm(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
