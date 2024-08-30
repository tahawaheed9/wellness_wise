import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/services/auth/auth_service.dart';

class UserCreatedOn extends StatefulWidget {
  const UserCreatedOn({super.key});

  @override
  State<UserCreatedOn> createState() => _UserCreatedOnState();
}

class _UserCreatedOnState extends State<UserCreatedOn> {
  @override
  Widget build(BuildContext context) {
    final docId = AuthService.firebase().currentUser!.id;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.exists) {
          final date = snapshot.data!['created-on'];
          final createdOn = DateFormat.yMMMEd('en_US').format(date.toDate());

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'User created on:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                createdOn,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          );
        }
        return Text(
          'N/A',
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }
}
