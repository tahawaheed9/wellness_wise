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
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('basic-information')
          .doc(docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final age = snapshot.data!['age'].toString();
          return Text(
            '$age yrs',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        }
        return const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
