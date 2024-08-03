import 'package:flutter/material.dart';

import '../constants/routes.dart';

void pushLoginScreen(BuildContext context) {
  Navigator.of(context).pushNamed(loginScreenRoute);
}

void pushRegisterScreen(BuildContext context) {
  Navigator.of(context).pushNamed(registerScreenRoute);
}

void pushOTPVerificationScreen(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    otpVerificationScreenRoute,
    ModalRoute.withName(
      '/otp-verification/',
    ),
  );
}

void pushResetPasswordScreen(BuildContext context) {
  Navigator.of(context).pushNamed(resetPasswordScreenRoute);
}

pushBasicInformationScreen(BuildContext context) {
  Navigator.of(context).pushNamed(basicInformationScreenRoute);
}

pushAdditionalInformationScreen(BuildContext context) {
  Navigator.of(context).pushNamed(additionalInformationScreenRoute);
}
