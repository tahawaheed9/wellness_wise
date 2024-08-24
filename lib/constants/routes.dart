import 'package:flutter/material.dart';

import '/screens/profile/profile_screen.dart';
import '/screens/register/register_screen.dart';
import '/screens/reset_password/reset_password_screen.dart';
import '../screens/additional_information/additional_information_screen.dart';
import '../screens/basic_information/basic_information_screen.dart';
import '../screens/charts/charts_screen.dart';
import '../screens/recommendations/recommendations_screen.dart';
import '/screens/health_outcomes/health_outcomes_screen.dart';
import '/screens/health_risks/health_risk_screen.dart';

const registerScreenRoute = '/register/';
const loginScreenRoute = '/login/';
const resetPasswordScreenRoute = '/reset-password/';
const basicInformationScreenRoute = '/basic-information/';
const additionalInformationScreenRoute = '/additional-information/';
const profileScreenRoute = '/profile/';
const healthOutcomeScreen = '/health-outcome/';
const healthRiskScreen = '/health-risk/';
const recommendationsScreen = '/recommendations/';
const chartsScreen = '/charts/';

Map<String, Widget Function(BuildContext)> routes = {
  registerScreenRoute: (context) => const RegisterScreen(),
  loginScreenRoute: (context) => const ResetPasswordScreen(),
  resetPasswordScreenRoute: (context) => const ResetPasswordScreen(),
  profileScreenRoute: (context) => const ProfileScreen(),
  basicInformationScreenRoute: (context) => const BasicInformationScreen(),
  additionalInformationScreenRoute: (context) =>
  const AdditionalInformationScreen(),
  healthOutcomeScreen: (context) => const HealthOutcomeScreen(),
  healthRiskScreen: (context) => const HealthRiskScreen(),
  recommendationsScreen: (context) => const RecommendationsScreen(),
  chartsScreen: (context) => const ChartsScreen(),
};
