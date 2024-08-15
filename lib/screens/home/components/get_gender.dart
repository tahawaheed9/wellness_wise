import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/auth/auth_service.dart';

class GetGender extends StatefulWidget {
  const GetGender({super.key});

  @override
  State<GetGender> createState() => _GetGenderState();
}

class _GetGenderState extends State<GetGender> {
  final docId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final gender = snapshot.data!['gender'];
          return Text(
            gender,
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
