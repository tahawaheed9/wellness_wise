import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/services/auth/auth_service.dart';

class GetAge extends StatefulWidget {
  const GetAge({super.key});

  @override
  State<GetAge> createState() => _GetAgeState();
}

class _GetAgeState extends State<GetAge> {
  late final Stream<DocumentSnapshot> _stream;
  final userId = AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('user-data')
        .doc(userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.exists) {
          final date = snapshot.data!['date-of-birth'].toDate();

          // Converting DOB to Age...
          final now = DateTime.now();
          final Duration age = now.difference(date);
          final int years = age.inDays ~/ 365;

          final formattedAge = years.toString();

          return Text(
            '$formattedAge y',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        } else {
          return Text(
            'N/A',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        }
      },
    );
  }
}
