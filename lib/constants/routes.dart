import 'package:flutter/material.dart';

import '/screens/heart_disease/heart_disease_screen.dart';
import '/screens/general_disease/general_disease_screen.dart';
import '/screens/register/register_screen.dart';
import '/screens/reset_password/reset_password_screen.dart';
import '../screens/additional_information/additional_information_screen.dart';

const registerScreenRoute = '/register/';
const loginScreenRoute = '/login/';
const resetPasswordScreenRoute = '/reset-password/';
const additionalInformationScreenRoute = '/additional-information/';
const generalDiseaseScreenRoute = '/general-disease/';
const heartDiseaseScreenRoute = '/heart-disease/';

Map<String, Widget Function(BuildContext)> routes = {
  registerScreenRoute: (context) => const RegisterScreen(),
  loginScreenRoute: (context) => const ResetPasswordScreen(),
  resetPasswordScreenRoute: (context) => const ResetPasswordScreen(),
  additionalInformationScreenRoute: (context) =>
  const AdditionalInformationScreen(),
  generalDiseaseScreenRoute: (context) => const GeneralDiseaseScreen(),
  heartDiseaseScreenRoute: (context) => const HeartDiseaseScreen(),
};
