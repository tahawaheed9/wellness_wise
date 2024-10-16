import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/presentation/components/dialogs/error_dialog.dart';
import '/data/services/database/database_service.dart';
import '/presentation/components/dialogs/delete_prediction_dialog.dart';
import '/data/services/auth/auth_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final DatabaseServices _db;
  final userId = AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    super.initState();
    _db = DatabaseServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: <Widget>[
            Icon(Icons.history_outlined),
            SizedBox(width: 5.0),
            Text('History'),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('user-data')
            .doc(userId)
            .collection('predictions')
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
              final disease = data['disease'] ?? 'N/A';
              final description = data['description'] ?? data['prediction'];
              final date = data['created-on'];

              // Formatting the date...
              final createdOn = DateFormat.yMMMd('en_US').format(date.toDate());

              return ListTile(
                horizontalTitleGap: 30,
                leading: Text(createdOn),
                title: Text(
                  disease,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  tooltip: 'Delete Prediction',
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    final docId = snapshot.data!.docs[index].id;
                    await _deletePrediction(context, docId);
                  },
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }

  // Delete Prediction...
  Future<void> _deletePrediction(BuildContext context, String docId) async {
    try {
      await showDeletePredictionDialog(context).then(<bool>(value) async {
        if (value) {
          await _db.deletePrediction(docId);
        }
      });
    } catch (error) {
      if (context.mounted) {
        await showErrorDialog(context, error.toString());
      }
    }
  }
}
