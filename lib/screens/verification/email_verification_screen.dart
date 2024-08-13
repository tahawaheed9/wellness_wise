import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/primary_button.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Icons.verified_user,
              color: Colors.teal,
              size: 100,
            ),
            const SizedBox(height: 50.0),
            Text(
              'We have sent you a verification email. '
              'Please, verify your email address in order to continue.',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 50.0),
            PrimaryButton(
              text: 'Continue',
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
            ),
            const SizedBox(height: 50.0),
            PrimaryButton(
              text: 'Resend Email',
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
            ),
          ],
        ),
      ),
    );
  }
}
