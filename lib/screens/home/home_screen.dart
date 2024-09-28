import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/home/components/saved_prediction_list.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '/components/dialogs/logout_dialog.dart';
import '/controller/screen_navigation_controller.dart';
import '/screens/home/components/custom_card.dart';
import '../../components/named_divider.dart';
import '/screens/home/components/user_information_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const UserInformationCard(),
                const NamedDivider(title: 'Health Predictions'),
                Row(
                  children: <Widget>[
                    CustomCard(
                      cardTitle: 'General Disease',
                      icon: Icons.medical_services_outlined,
                      onTap: () {
                        pushGeneralDiseaseScreen(context);
                      },
                    ),
                    CustomCard(
                      cardTitle: 'Heart Disease',
                      icon: Icons.favorite_outline,
                      onTap: () {
                        pushHeartDiseaseScreen(context);
                      },
                    ),
                  ],
                ),
                CustomCard(
                  cardTitle: 'Diabetes Predictions',
                  icon: Icons.medical_services_outlined,
                  onTap: () {
                    pushDiabetesPredictionsScreen(context);
                  },
                ),
                const NamedDivider(title: 'Chronic Disease Predictions'),
                Row(
                  children: <Widget>[
                    CustomCard(
                      cardTitle: 'Kidney Predictions',
                      icon: Icons.signal_cellular_alt_outlined,
                      onTap: () {
                        pushKidneyPredictionsScreen(context);
                      },
                    ),
                    CustomCard(
                      cardTitle: 'Lung Cancer',
                      icon: Icons.person_outline,
                      onTap: () {},
                    ),
                  ],
                ),
                CustomCard(
                  cardTitle: 'Breast Cancer',
                  icon: Icons.person_outline,
                  onTap: () {},
                ),
                const NamedDivider(title: 'Trends'),
                const SavedPredictionList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
