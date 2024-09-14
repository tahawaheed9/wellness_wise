import 'package:flutter/material.dart';

import '../constants/routes.dart';

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

// Reset Password...
void pushResetPasswordScreen(BuildContext context) {
  Navigator.of(context).pushNamed(resetPasswordScreenRoute);
}

// Additional Information...
void pushAdditionalInformationScreen(BuildContext context) {
  Navigator.of(context).pushNamed(additionalInformationScreenRoute);
}

// General Disease...
void pushGeneralDiseaseScreen(BuildContext context) {
  Navigator.of(context).pushNamed(generalDiseaseScreenRoute);
}

// Heart Failure...
void pushHeartFailureScreen(BuildContext context) {
  Navigator.of(context).pushNamed(heartFailureScreenRoute);
}

// Diabetes Predictions...
void pushDiabetesPredictionsScreen(BuildContext context) {
  Navigator.of(context).pushNamed(diabetesPredictionsScreenRoute);
}
