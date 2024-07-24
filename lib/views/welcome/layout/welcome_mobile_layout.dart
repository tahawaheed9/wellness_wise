import 'package:flutter/material.dart';

import '../../../views/welcome/controller/page_navigator.dart';
import '../../../components/primary_button.dart';

class WelcomeMobileLayout extends StatelessWidget {
  const WelcomeMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
              pushLoginView(context);
            },
          ),
          const SizedBox(height: 20.0),
          PrimaryButton(
            text: 'Register',
            onPressed: () {
              pushRegisterView(context);
            },
          ),
        ],
      ),
    );
  }
}
