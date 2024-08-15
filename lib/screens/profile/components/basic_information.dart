import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/screens/home/components/get_age.dart';
import '/services/auth/auth_service.dart';
import '/screens/home/components/get_gender.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  @override
  Widget build(BuildContext context) {
    final docId = AuthService.firebase().currentUser!.id;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('basic-information')
          .doc(docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final height = snapshot.data!['height'].toString();
          final weight = snapshot.data!['weight'].toString();
          final lifestyleHabits = snapshot.data!['lifestyle-habits'].toString();
          final medicalHistory = snapshot.data!['medical-history'].toString();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Age...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Age:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const GetAge(),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Gender...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Gender:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const GetGender(),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Height...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Height:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      height,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Weight...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Weight: ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      weight,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Lifestyle Habits...
                Text(
                  'Lifestyle Habits:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  lifestyleHabits,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10.0),

                // Medical History...
                Text(
                  'Medical History:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  medicalHistory,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
