import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/auth/auth_service.dart';

class GetAge extends StatefulWidget {
  const GetAge({super.key});

  @override
  State<GetAge> createState() => _GetAgeState();
}

class _GetAgeState extends State<GetAge> {
  final docId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('basic-information')
          .orderBy('created-on', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Text(
            'N/A',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        } else if (snapshot.hasError) {
          return Text(
            'N/A',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        }
        // Getting the recent document...
        final recentDocument = snapshot.data!.docs.first;
        // Fetching the data from the recent document...
        final data = recentDocument.data();
        return Text(
          data['age'] != null ? '${data['age']} y' : 'N/A',
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }
}
