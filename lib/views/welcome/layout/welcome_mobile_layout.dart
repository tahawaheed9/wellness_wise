import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/primary_button.dart';
import '../../../constants/routes.dart';

class WelcomeMobileLayout extends StatelessWidget {
  const WelcomeMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/lined_heart.svg',
            semanticsLabel: 'Lined Heart Icon',
            height: 100,
            width: 100,
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
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginViewRoute, (_) => false);
            },
          ),
          PrimaryButton(
            text: 'Register',
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerViewRoute, (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
