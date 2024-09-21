import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/screens/home/components/prediction_card.dart';
import '/services/auth/auth_service.dart';

class SavedPredictionList extends StatefulWidget {
  const SavedPredictionList({super.key});

  @override
  State<SavedPredictionList> createState() => _SavedPredictionListState();
}

class _SavedPredictionListState extends State<SavedPredictionList> {
  final userId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(userId)
          .collection('predictions')
          .orderBy('created-on', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: [
                const CircularProgressIndicator(),
                Text(
                  'Fetching...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
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
        return SizedBox(
          height: 160,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final recentDocument = snapshot.data!.docs.first;
              final data = recentDocument.data();

              final date = data['created-on'];
              final createdOn = DateFormat.yMMMd('en_US').format(date.toDate());

              return PredictionCard(
                diseaseTitle: data['disease'] ?? 'N/A',
                date: createdOn,
              );
            },
          ),
        );
      },
    );
  }
}
