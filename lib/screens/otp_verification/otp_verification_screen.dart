import 'package:flutter/material.dart';

import '/components/primary_button.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

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
                  child: TextField(
                    controller: _otp,
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
                  onPressed: () {},
                ),
                const SizedBox(height: 20.0),

                // Resend OTP Button...
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend Code',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
