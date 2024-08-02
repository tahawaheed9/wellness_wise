import 'package:flutter/material.dart';

import '../../controller/page_navigator.dart';
import '../../../components/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WellnessWise',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Your AI Health Navigator',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 50.0),
            PrimaryButton(
              text: 'Log in',
              onPressed: () {
                pushLoginScreen(context);
              },
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              text: 'Register',
              onPressed: () {
                pushRegisterScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
