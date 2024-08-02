import 'package:flutter/material.dart';

import '/screens/login/components/login_form.dart';
import '/components/primary_button.dart';
import '../../controller/page_navigator.dart';
import '/screens/login/components/reset_password_button.dart';
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
                const ResetPasswordButton(),
                const SizedBox(height: 75.0),
        
                // Create An Account...
                PrimaryButton(
                  text: 'Create new account',
                  onPressed: () {
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
