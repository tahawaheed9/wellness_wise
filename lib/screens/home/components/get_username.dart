import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUsername extends StatefulWidget {
  const GetUsername({super.key});

  @override
  State<GetUsername> createState() => _GetUsernameState();
}

class _GetUsernameState extends State<GetUsername> {
  final docId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final username = snapshot.data!['username'];
            return Text(
              username,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
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
