import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('additional-information')
          .doc(docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final sysBloodPressure =
              snapshot.data!['systolic-blood-pressure'].toString();
          final diaBloodPressure =
              snapshot.data!['diastolic-blood-pressure'].toString();
          final heartRate = snapshot.data!['heart-rate'].toString();
          final bloodSugarLevels =
              snapshot.data!['blood-sugar-levels'].toString();
          final cholesterolLevels =
              snapshot.data!['cholesterol-levels'].toString();

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
                      sysBloodPressure,
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
                      diaBloodPressure,
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
                      heartRate,
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
                      'Sugar Levels:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      bloodSugarLevels,
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
                      cholesterolLevels,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
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
