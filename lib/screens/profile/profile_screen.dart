import 'package:flutter/material.dart';

import '/screens/profile/components/user_created_on.dart';
import '/screens/profile/components/additional_information.dart';
import '/screens/profile/components/basic_information.dart';
import '/components/named_divider.dart';
import '/screens/profile/components/profile_header.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProfileHeader(),
              SizedBox(height: 30.0),
              UserCreatedOn(),
              Divider(),
              NamedDivider(title: 'Basic Information'),
              BasicInformation(),
              Divider(),
              NamedDivider(title: 'Additional Information'),
              AdditionalInformation(),
            ],
          ),
        ),
      ),
    );
  }
}
