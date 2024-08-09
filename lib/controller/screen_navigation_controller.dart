import 'package:flutter/material.dart';

import '../constants/routes.dart';

void pushWelcomeScreen(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    welcomeScreenRoute,
    ModalRoute.withName('/welcome/'),
  );
}

// Login...
void pushLoginScreen(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    loginScreenRoute,
    ModalRoute.withName('/login/'),
  );
}

// Register...
void pushRegisterScreen(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    registerScreenRoute,
    ModalRoute.withName('/register/'),
  );
}

// Home...
void pushHomeScreen(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    homeScreenRoute,
    ModalRoute.withName('/home/'),
  );
}

// Reset Password...
void pushResetPasswordScreen(BuildContext context) {
  Navigator.of(context).pushNamed(resetPasswordScreenRoute);
}

// Basic Information...
void pushBasicInformationScreen(BuildContext context) {
  Navigator.of(context).pushNamed(basicInformationScreenRoute);
}

// Additional Information...
void pushAdditionalInformationScreen(BuildContext context) {
  Navigator.of(context).pushNamed(additionalInformationScreenRoute);
}

// Personalized Recommendations...
void pushRecommendationsScreen(BuildContext context) {
  Navigator.of(context).pushNamed(recommendationsScreen);
}

// Charts...
void pushChartsScreen(BuildContext context) {
  Navigator.of(context).pushNamed(chartsScreen);
}
