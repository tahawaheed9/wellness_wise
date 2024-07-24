import 'package:flutter/material.dart';

import '../../../views/welcome/controller/page_navigator.dart';
import '../../../components/primary_button.dart';

class WelcomeTabletLayout extends StatelessWidget {
  const WelcomeTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'WellnessWise',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 30),
              ),
              Text(
                'Your AI Health Navigator',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                text: 'Log in',
                onPressed: () {
                  pushLoginView(context);
                },
              ),
              PrimaryButton(
                text: 'Register',
                onPressed: () {
                  pushRegisterView(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
