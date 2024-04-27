import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import '../views/register/register_view.dart';
import '../views/login/login_view.dart';
import '../views/welcome/welcome_view.dart';
import '../constants/routes.dart';

void main() async {
  // Ensuring all the widgets are ready for use
  WidgetsFlutterBinding.ensureInitialized();

  // Setting the background for the status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
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
        loginViewRoute: (context) => const LoginView(),
        registerViewRoute: (context) => const RegisterView(),
      },
      home: const WelcomeView(),
    );
  }
}
