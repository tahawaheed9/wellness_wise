import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/routes.dart';
import '../screens/welcome/welcome_screen.dart';

void main() async {
  // Ensuring all the widgets are ready for use
  WidgetsFlutterBinding.ensureInitialized();

  // Setting Preferred Orientation to PortraitUp...
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
      routes: routes,
      home: const WelcomeScreen(),
    );
  }
}
