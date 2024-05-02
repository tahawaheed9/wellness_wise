import 'package:flutter/material.dart';
import 'package:wellness_wise/views/welcome/layout/welcome_tablet_layout.dart';

import '../responsive/responsive_view.dart';
import '../../../views/welcome/layout/welcome_mobile_layout.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveView(
        mobile: WelcomeMobileLayout(),
        tablet: WelcomeTabletLayout(),
      ),
    );
  }
}
