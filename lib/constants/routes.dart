import 'package:flutter/material.dart';

import '/screens/general_disease/general_disease_screen.dart';
import '/screens/register/register_screen.dart';
import '/screens/reset_password/reset_password_screen.dart';
import '../screens/additional_information/additional_information_screen.dart';
import '../screens/charts/charts_screen.dart';

const registerScreenRoute = '/register/';
const loginScreenRoute = '/login/';
const resetPasswordScreenRoute = '/reset-password/';
const basicInformationScreenRoute = '/basic-information/';
const additionalInformationScreenRoute = '/additional-information/';
const generalDiseaseScreenRoute = '/general-disease/';
const chartsScreen = '/charts/';

Map<String, Widget Function(BuildContext)> routes = {
  registerScreenRoute: (context) => const RegisterScreen(),
  loginScreenRoute: (context) => const ResetPasswordScreen(),
  resetPasswordScreenRoute: (context) => const ResetPasswordScreen(),
  additionalInformationScreenRoute: (context) =>
  const AdditionalInformationScreen(),
  generalDiseaseScreenRoute: (context) => const GeneralDiseaseScreen(),
  chartsScreen: (context) => const ChartsScreen(),
};
