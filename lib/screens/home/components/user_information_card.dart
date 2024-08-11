import 'package:flutter/material.dart';

class UserInformationCard extends StatefulWidget {
  const UserInformationCard({super.key});

  @override
  State<UserInformationCard> createState() => _UserInformationCardState();
}

class _UserInformationCardState extends State<UserInformationCard> {
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
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),

          // Age & Gender...
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Age',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Gender',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
