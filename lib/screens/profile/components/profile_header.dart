import 'package:flutter/material.dart';

import '../../home/components/get_username.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            maxRadius: 40,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: const Icon(
              Icons.person_outline,
              size: 40,
            ),
          ),
          const SizedBox(height: 20.0),
          const GetUsername(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
