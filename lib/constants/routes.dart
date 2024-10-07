import 'package:flutter/material.dart';

import '/screens/breast_cancer/breast_cancer_screen.dart';
import '/screens/lung_cancer/lung_cancer_screen.dart';
import '/screens/kidney_predictions/kidney_predictions_screen.dart';
import '/screens/diabetes_predictions/diabetes_predictions_screen.dart';
import '/screens/heart_disease/heart_disease_screen.dart';
import '/screens/general_disease/general_disease_screen.dart';
import '/screens/register/register_screen.dart';
import '/screens/reset_password/reset_password_screen.dart';

const registerScreenRoute = '/register/';
const loginScreenRoute = '/login/';
const resetPasswordScreenRoute = '/reset-password/';
const generalDiseaseScreenRoute = '/general-disease/';
const heartDiseaseScreenRoute = '/heart-disease/';
const diabetesPredictionsScreenRoute = '/diabetes-predictions/';
const kidneyPredictionsScreenRoute = '/kidney-predictions/';
const lungCancerScreenRoute = '/lung-cancer/';
const breastCancerScreenRoute = '/breast-cancer/';

Map<String, Widget Function(BuildContext)> routes = {
  registerScreenRoute: (context) => const RegisterScreen(),
  loginScreenRoute: (context) => const ResetPasswordScreen(),
  resetPasswordScreenRoute: (context) => const ResetPasswordScreen(),
  generalDiseaseScreenRoute: (context) => const GeneralDiseaseScreen(),
  heartDiseaseScreenRoute: (context) => const HeartDiseaseScreen(),
  diabetesPredictionsScreenRoute: (context) => const DiabetesPredictionScreen(),
  kidneyPredictionsScreenRoute: (context) => const KidneyPredictionsScreen(),
  lungCancerScreenRoute: (context) => const LungCancerScreen(),
  breastCancerScreenRoute: (context) => const BreastCancerScreen(),
};
