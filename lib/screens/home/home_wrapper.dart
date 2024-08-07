import 'package:flutter/material.dart';

import '/services/auth/auth_service.dart';
import '/screens/home/home_screen.dart';
import '/screens/login/login_screen.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
