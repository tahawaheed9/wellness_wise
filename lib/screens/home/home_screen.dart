import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/components/dialogs/logout_dialog.dart';
import '../../components/dialogs/error_dialog.dart';
import '/controller/screen_navigation_controller.dart';
import '/screens/home/components/custom_card.dart';
import '../../components/named_divider.dart';
import '/screens/home/components/user_information_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void>logoutUser() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseAuth.instance.signOut();
      } else {
        await showErrorDialog(context, 'User not logged in.');
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              final shouldLogout = await showLogoutDialog(context);
              if (shouldLogout) {
                await logoutUser();
                if (context.mounted) {
                  pushWelcomeScreen(context);
                }
              }
            },
            tooltip: 'Log out',
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const UserInformationCard(),
                  const NamedDivider(title: 'Health Data'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        cardTitle: 'Basic Information',
                        icon: Icons.medical_information_outlined,
                        onTap: () {
                          pushBasicInformationScreen(context);
                        },
                      ),
                      CustomCard(
                        cardTitle: 'Additional Information',
                        icon: Icons.medical_information_outlined,
                        onTap: () {
                          pushAdditionalInformationScreen(context);
                        },
                      ),
                    ],
                  ),
                  const NamedDivider(title: 'Health Analysis'),
                  CustomCard(
                    cardTitle: 'Personalized Recommendations',
                    icon: Icons.recommend_outlined,
                    onTap: () {
                      pushRecommendationsScreen(context);
                    },
                  ),
                  const NamedDivider(title: 'Data Visualization'),
                  CustomCard(
                    cardTitle: 'Charts',
                    icon: Icons.bar_chart_sharp,
                    onTap: () {
                      pushChartsScreen(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
