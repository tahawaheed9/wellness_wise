import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../components/primary_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 125.0,
              backgroundImage: AssetImage('assets/images/welcome.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Log in',
              onPressed: () {
                Navigator.of(context).pushNamed(loginViewRoute);
              },
            ),
            PrimaryButton(
              text: 'Register',
              onPressed: () {
                Navigator.of(context).pushNamed(registerViewRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
