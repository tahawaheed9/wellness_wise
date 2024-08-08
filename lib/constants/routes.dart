import 'package:flutter/material.dart';

import '/screens/welcome/welcome_screen.dart';
import '../screens/additional_information/additional_information_screen.dart';
import '../screens/basic_information/basic_information_screen.dart';
import '../screens/charts/charts_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/otp_verification/otp_verification_screen.dart';
import '../screens/personalized_recommendations/recommendations_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/reset_password/reset_password_screen.dart';


const welcomeScreenRoute = '/welcome/';
const loginScreenRoute = '/login/';
const registerScreenRoute = '/register/';
const otpVerificationScreenRoute = '/otp-verification/';
const resetPasswordScreenRoute = '/reset-password/';
const homeScreenRoute = '/home/';
const basicInformationScreenRoute = '/basic-information/';
const additionalInformationScreenRoute = '/additional-information/';
const recommendationsScreen = '/recommendations/';
const chartsScreen = '/charts/';

Map<String, Widget Function(BuildContext)> routes = {
  welcomeScreenRoute: (context) => const WelcomeScreen(),
  loginScreenRoute: (context) => const LoginScreen(),
  registerScreenRoute: (context) => const RegisterScreen(),
  otpVerificationScreenRoute: (context) => const OTPVerificationScreen(),
  resetPasswordScreenRoute: (context) => const ResetPasswordScreen(),
  homeScreenRoute: (context) => const HomeScreen(),
  basicInformationScreenRoute: (context) => const BasicInformationScreen(),
  additionalInformationScreenRoute: (context) =>
  const AdditionalInformationScreen(),
  recommendationsScreen: (context) => const RecommendationsScreen(),
  chartsScreen: (context) => const ChartsScreen(),
};
