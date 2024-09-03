import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/services/auth/auth_service.dart';
import '/screens/home/components/get_gender.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final docId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('basic-information')
          .orderBy('created-on', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
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
        // Getting the recent document...
        final recentDocument = snapshot.data!.docs.first;

        // Fetching the data from the recent document...
        final data = recentDocument.data();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Age...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Age:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['age'] != null ? '${data['age']} years' : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Gender...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Gender:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const GetGender(),
                ],
              ),
              const SizedBox(height: 10.0),

              // Height...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Height:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['height'] != null ? '${data['height']} cm' : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Weight...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Weight: ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    data['weight'] != null ? '${data['weight']} Kg' : 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Lifestyle Habits...
              Text(
                'Lifestyle Habits:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                child: Text(
                  data['lifestyle-habits'] != null
                      ? ' — ${data['lifestyle-habits']}'
                      : ' — N/A',
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 10.0),

              // Medical History...
              Text(
                'Medical History:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                child: Text(
                  data['medical-history'] != null
                      ? ' — ${data['medical-history']}'
                      : ' — N/A',
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
