import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/services/auth/auth_service.dart';

class GetUsername extends StatefulWidget {
  const GetUsername({super.key});

  @override
  State<GetUsername> createState() => _GetUsernameState();
}

class _GetUsernameState extends State<GetUsername> {
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
          final username = snapshot.data!['username'];
          return Text(
            username,
            overflow: TextOverflow.ellipsis,
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          );
        } else {
          return Text(
            'N/A',
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          );
        }
      },
    );
  }
}