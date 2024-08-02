import 'package:flutter/material.dart';

import '/controller/page_navigator.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushResetPasswordScreen(context);
      },
      child: Text(
        'Reset Password',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.deepPurple),
      ),
    );
  }
}
