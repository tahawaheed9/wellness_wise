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

// General Disease...
void pushGeneralDiseaseScreen(BuildContext context) {
  Navigator.of(context).pushNamed(generalDiseaseScreenRoute);
}

// Heart Disease...
void pushHeartDiseaseScreen(BuildContext context) {
  Navigator.of(context).pushNamed(heartDiseaseScreenRoute);
}

// Diabetes Predictions...
void pushDiabetesPredictionsScreen(BuildContext context) {
  Navigator.of(context).pushNamed(diabetesPredictionsScreenRoute);
}

// Kidney Predictions...
void pushKidneyPredictionsScreen(BuildContext context) {
  Navigator.of(context).pushNamed(kidneyPredictionsScreenRoute);
}

// Lung Cancer...
void pushLungCancerScreen(BuildContext context) {
  Navigator.of(context).pushNamed(lungCancerScreenRoute);
}

// Breast Cancer...
void pushBreastCancerScreen(BuildContext context) {
  Navigator.of(context).pushNamed(breastCancerScreenRoute);
}
