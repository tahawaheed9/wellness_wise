import 'package:flutter/material.dart';

import '/controller/screen_navigation_controller.dart';
import '/screens/home/components/custom_card.dart';
import '../../components/named_divider.dart';
import '/screens/home/components/user_information_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
