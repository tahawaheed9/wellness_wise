import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

import '/components/dialogs/error_dialog.dart';
import '/components/primary_button.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late final TextEditingController _otp;

  @override
  void initState() {
    super.initState();
    _otp = TextEditingController();
  }

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50.0),
                Text(
                  'An OTP has been sent to your phone number.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 30.0),

                // OTP Field...
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: _otp,
                    autofocus: true,
                    maxLength: 6,
                    autocorrect: false,
                    enableSuggestions: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      letterSpacing: 10.0,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),

                // Verify Button...
                PrimaryButton(
                    text: 'Verify',
                    onPressed: () async {
                      final String otp = _otp.text;
                      bool isOTPVerified = EmailOTP.verifyOTP(otp: otp);
                      if (isOTPVerified) {
                        if (context.mounted) {
                          Navigator.pop(context, isOTPVerified);
                        }
                      } else {
                        if (context.mounted) {
                          await showErrorDialog(
                            context,
                            'Invalid OTP or failed to authorize the user. '
                            'Please try again later',
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
