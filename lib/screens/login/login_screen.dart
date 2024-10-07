import 'package:flutter/material.dart';

import '/screens/login/components/login_form.dart';
import '/components/screen_heading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                ScreenHeading(
                  icon: Icons.person_outline,
                  headingText: 'Login',
                ),
                SizedBox(height: 50.0),

                // Login Form
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
