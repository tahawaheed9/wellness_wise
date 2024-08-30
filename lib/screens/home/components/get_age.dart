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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('basic-information')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'N/A',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else {
          final age = snapshot.data?.docs.last['age'];
          return Text(
            '$age y',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        }
      },
    );
  }
}
