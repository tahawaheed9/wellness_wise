import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/primary_button.dart';
import '../../../constants/routes.dart';

class WelcomeTabletLayout extends StatelessWidget {
  const WelcomeTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/lined_heart.svg',
            height: 300,
            width: 300,
          ),
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
        ],
      ),
    );
  }
}
