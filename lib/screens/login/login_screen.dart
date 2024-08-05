import 'package:flutter/material.dart';

import '/screens/login/components/login_form.dart';
import '../../controller/screen_navigation_controller.dart';
import '../../components/text_button.dart';
import '/components/screen_heading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  headingText: 'Login',
                ),
                const SizedBox(height: 50.0),

                // Login Form
                const LoginForm(),

                // Reset Password Button...
                MyTextButton(
                  title: 'Reset Password',
                  onTap: () {
                    pushResetPasswordScreen(context);
                  },
                ),
                const SizedBox(height: 75.0),

                // Create An Account...
                MyTextButton(
                  title: 'Create an account',
                  onTap: () {
                    pushRegisterScreen(context);
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
