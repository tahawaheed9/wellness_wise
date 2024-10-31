import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/presentation/components/custom_filter.dart';
import '/data/services/auth/auth_service.dart';
import '/data/services/database/database_service.dart';
import '/presentation/components/dialogs/error_dialog.dart';
import '/presentation/components/success_snack_bar.dart';
import '/presentation/components/dialogs/delete_dialog.dart';
import '/presentation/screens/notifications/components/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final DatabaseServices _db;
  final userId = AuthService.firebase().currentUser!.id;

  String? _selectedValue;
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _db = DatabaseServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CustomFilter(
              onChanged: (value) {
                _selectedValue = value;
                setState(() {
                  _date = _calculateTime(_selectedValue!);
                });
              },
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('user-data')
                  .doc(userId)
                  .collection('notifications')
                  .where('created-on', isGreaterThan: _date)
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
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16.0),
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, _) => SizedBox(height: 30.0),
                  itemBuilder: (context, index) {
                    // Fetching the documents...
                    final DocumentSnapshot<Map<String, dynamic>> document =
                        snapshot.data!.docs[index];

                    // Fetching the data from the documents...
                    final Map<String, dynamic> data = document.data()!;

                    // Assigning the data...
                    final docId = snapshot.data!.docs[index].id;
                    final notificationTitle = data['title'] ?? 'N/A';
                    final notificationBody = data['body'];
                    final date = data['created-on'];

                    // Formatting the date...
                    final createdOn =
                        DateFormat.yMMMd('en_US').format(date.toDate());

                    return NotificationCard(
                      title: notificationTitle,
                      body: notificationBody,
                      date: createdOn,
                      onTap: () async {
                        await _deleteNotification(docId);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DateTime _calculateTime(String filter) {
    switch (filter) {
      case 'Past 24 hours':
        final now = DateTime.now();
        final past24Hours = now.subtract(Duration(hours: 24));
        return past24Hours;

      case 'Past week':
        final now = DateTime.now();
        final pastWeek = now.subtract(Duration(days: 7));
        return pastWeek;

      case 'Past month':
        final now = DateTime.now();
        final pastMonth = now.subtract(Duration(days: 30));
        return pastMonth;

      default:
        final allTime = DateTime.now();
        return allTime;
    }
  }

  Future<void> _deleteNotification(String docId) async {
    try {
      await showDeleteDialog(context).then(<bool>(value) async {
        if (value) {
          await _db.deleteNotification(docId).whenComplete(<bool>() {
            ScaffoldMessenger.of(context).showSnackBar(
              showSuccessSnackBar(
                context,
                'Successfully deleted.',
                Icons.check_circle_outline,
              ),
            );
          });
        }
      });
    } catch (error) {
      if (context.mounted) {
        await showErrorDialog(context, error.toString());
      }
    }
  }
}
