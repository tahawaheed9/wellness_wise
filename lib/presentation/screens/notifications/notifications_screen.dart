import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/data/services/auth/auth_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final userId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('user-data')
            .doc(userId)
            .collection('notifications')
            .orderBy('created-on', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 5.0),
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
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => SizedBox(height: 20.0),
            itemBuilder: (context, index) {
              // Fetching the documents...
              final DocumentSnapshot<Map<String, dynamic>> document =
                  snapshot.data!.docs[index];

              // Fetching the data from the documents...
              final Map<String, dynamic> data = document.data()!;

              // Assigning the data...
              final notificationTitle = data['title'] ?? 'N/A';
              final notificationBody = data['body'];
              final date = data['created-on'];

              // Formatting the date...
              final createdOn = DateFormat.yMMMd('en_US').format(date.toDate());

              return ListTile(
                horizontalTitleGap: 30,
                leading: Text(createdOn),
                title: Text(
                  notificationTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  notificationBody,
                  overflow: TextOverflow.ellipsis,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
