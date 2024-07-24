import 'package:flutter/material.dart';

import '../../../views/login/layout/login_mobile_layout.dart';
import '../../views/login/layout/login_tablet_layout.dart';
import '../../views/responsive/responsive_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveView(
        mobile: LoginMobileLayout(),
        tablet: LoginTabletLayout(),
      ),
    );
  }
}
