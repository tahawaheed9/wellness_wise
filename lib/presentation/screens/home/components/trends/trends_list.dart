import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/business/controller/responsive_screen_controller.dart';
import 'trends_card.dart';
import '/data/services/auth/auth_service.dart';

class TrendsList extends StatefulWidget {
  const TrendsList({super.key});

  @override
  State<TrendsList> createState() => _TrendsListState();
}

class _TrendsListState extends State<TrendsList> {
  final userId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(userId)
          .collection('predictions')
          .orderBy('created-on', descending: true)
          .limit(7)
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
          height: screenHeight(context) * 0.18,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // Fetching the documents...
              final DocumentSnapshot<Map<String, dynamic>> document =
                  snapshot.data!.docs[index];

              // Fetching the data from the documents...
              final Map<String, dynamic> data = document.data()!;

              // Assigning the data...
              final disease = data['disease'] ?? 'N/A';
              final date = data['created-on'];

              // Formatting the date...
              final createdOn = DateFormat.yMMMd('en_US').format(date.toDate());

              return TrendsCard(
                diseaseTitle: disease,
                date: createdOn,
              );
            },
          ),
        );
      },
    );
  }
}
