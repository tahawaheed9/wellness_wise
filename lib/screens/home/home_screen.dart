import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/dialogs/logout_dialog.dart';
import '../../../../components/named_divider.dart';
import '../../../../controller/screen_navigation_controller.dart';
import '../../../../services/auth/bloc/auth_bloc.dart';
import '../../../../services/auth/bloc/auth_event.dart';
import 'components/screen_navigation_card.dart';
import 'components/trends/trends_list.dart';
import 'components/user_information/user_information_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Wise'),
        centerTitle: true,
        actions: <Widget>[
          // Log out Button...
          IconButton(
            onPressed: () async {
              final shouldLogout = await showLogoutDialog(context);
              if (shouldLogout) {
                if (context.mounted) {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                }
              }
            },
            tooltip: 'Log out',
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const UserInformationCard(),
              const NamedDivider(title: 'Health Predictions'),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.8,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ScreenNavigationCard(
                    cardTitle: 'General Disease',
                    icon: Icons.medical_services_outlined,
                    onTap: () {
                      pushGeneralDiseaseScreen(context);
                    },
                  ),
                  ScreenNavigationCard(
                    cardTitle: 'Heart Disease',
                    icon: Icons.favorite_outline,
                    onTap: () {
                      pushHeartDiseaseScreen(context);
                    },
                  ),
                  ScreenNavigationCard(
                    cardTitle: 'Diabetes Predictions',
                    icon: Icons.medical_services_outlined,
                    onTap: () {
                      pushDiabetesPredictionsScreen(context);
                    },
                  ),
                ],
              ),
              const NamedDivider(title: 'Chronic Disease Predictions'),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.8,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ScreenNavigationCard(
                    cardTitle: 'Kidney Predictions',
                    icon: Icons.medical_services_outlined,
                    onTap: () {
                      pushKidneyPredictionsScreen(context);
                    },
                  ),
                  ScreenNavigationCard(
                    cardTitle: 'Lung Cancer',
                    icon: Icons.person_outline,
                    onTap: () {
                      pushLungCancerScreen(context);
                    },
                  ),
                  ScreenNavigationCard(
                    cardTitle: 'Breast Cancer',
                    icon: Icons.person_outline,
                    onTap: () {
                      pushBreastCancerScreen(context);
                    },
                  ),
                ],
              ),
              const NamedDivider(title: 'Trends'),
              const TrendsList(),
            ],
          ),
        ),
      ),
    );
  }
}
