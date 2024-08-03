import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import '/screens/otp_verification/otp_verification_screen.dart';
import '/screens/additional_information/additional_information_screen.dart';
import '/screens/basic_information/basic_information_screen.dart';
import '../screens/reset_password/reset_password_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import '../constants/routes.dart';

void main() async {
  // Ensuring all the widgets are ready for use
  WidgetsFlutterBinding.ensureInitialized();

  // Setting the background for the status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status Bar Customization...
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,

      // System Navigation Bar Customization...
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initializing the Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness Wise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        loginScreenRoute: (context) => const LoginScreen(),
        registerScreenRoute: (context) => const RegisterScreen(),
        otpVerificationScreenRoute: (context) => const OTPVerificationScreen(),
        resetPasswordScreenRoute: (context) => const ResetPasswordScreen(),
        basicInformationScreenRoute: (context) =>
            const BasicInformationScreen(),
        additionalInformationScreenRoute: (context) =>
            const AdditionalInformationScreen(),
      },
      home: const WelcomeScreen(),
    );
  }
}
