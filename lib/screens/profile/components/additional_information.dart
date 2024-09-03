import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/services/auth/auth_service.dart';

class AdditionalInformation extends StatefulWidget {
  const AdditionalInformation({super.key});

  @override
  State<AdditionalInformation> createState() => _AdditionalInformationState();
}

class _AdditionalInformationState extends State<AdditionalInformation> {
  final docId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('additional-information')
          .orderBy('created-on', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error retrieving data...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No Record Found...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        // Getting the recent document...
        final recentDocument = snapshot.data!.docs.first;

        // Fetching the data from the document...
        final data = recentDocument.data();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Systolic & Diastolic Blood Pressure...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Systolic Blood Pressure...
                  Text(
                    'Systolic Blood Pressure:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['systolic-blood-pressure'] != null
                        ? '${data['systolic-blood-pressure']} mmHg'
                        : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Diastolic Blood Pressure...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Diastolic Blood Pressure:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['diastolic-blood-pressure'] != null
                        ? '${data['diastolic-blood-pressure']} mmHg'
                        : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Heart Rate...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Heart Rate:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['heart-rate'] != null
                        ? '${data['heart-rate']} bpm'
                        : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Blood Sugar Levels...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Blood Sugar Levels:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['blood-sugar-levels'] != null
                        ? '${data['blood-sugar-levels']} mg/dL'
                        : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Cholesterol Levels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Systolic Blood Pressure...
                  Text(
                    'Cholesterol Levels:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['cholesterol-levels'] != null
                        ? '${data['cholesterol-levels']} mg/dL'
                        : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
