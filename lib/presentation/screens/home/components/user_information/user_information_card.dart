import 'package:flutter/material.dart';

import 'get_gender.dart';
import 'get_age.dart';
import 'get_username.dart';

class UserInformationCard extends StatelessWidget {
  const UserInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Person Avatar...
          const CircleAvatar(
            maxRadius: 32,
            backgroundColor: Colors.black12,
            child: Icon(
              Icons.person_outline,
              size: 32,
            ),
          ),
          const SizedBox(width: 20.0),

          // Salutations...
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hello,',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const GetUsername(),
              ],
            ),
          ),
          const SizedBox(width: 20.0),

          // Age & Gender...
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GetGender(),
              GetAge(),
            ],
          ),
        ],
      ),
    );
  }
}