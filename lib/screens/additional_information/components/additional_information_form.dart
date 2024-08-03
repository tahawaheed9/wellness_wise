import 'package:flutter/material.dart';

import '/components/primary_button.dart';

class AdditionalInformationForm extends StatefulWidget {
  const AdditionalInformationForm({super.key});

  @override
  State<AdditionalInformationForm> createState() =>
      _AdditionalInformationFormState();
}

class _AdditionalInformationFormState extends State<AdditionalInformationForm> {
  final _additionalInformationFormKey =
      GlobalKey<_AdditionalInformationFormState>();

  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController heartRate = TextEditingController();
  final TextEditingController bloodSugarLevels = TextEditingController();
  final TextEditingController cholesterolLevels = TextEditingController();

  @override
  void dispose() {
    bloodPressure.dispose();
    heartRate.dispose();
    bloodSugarLevels.dispose();
    cholesterolLevels.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _additionalInformationFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Blood Pressure & Heart Rate Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Blood Pressure Field...
                Expanded(
                  child: TextFormField(
                    controller: bloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Blood Pressure',
                      hintText: '120 / 80',
                      suffixText: 'mmHg',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 30.0),

                // Heart Rate Field...
                Expanded(
                  child: TextFormField(
                    controller: heartRate,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Heart Rate',
                      hintText: '72',
                      suffixText: 'bps',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // Blood Sugar & Cholesterol Levels Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Blood Sugar Levels Field...
                Expanded(
                  child: TextFormField(
                    controller: bloodSugarLevels,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Blood Sugar Levels',
                      hintText: '90',
                      suffixText: 'mg/dL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 30.0),

                // Cholesterol Levels Field...
                Expanded(
                  child: TextFormField(
                    controller: cholesterolLevels,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cholesterol Levels',
                      hintText: 'LDL + HDL',
                      suffixText: 'mg/dL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),

            // Save Information Button...
            PrimaryButton(
              text: 'Save Information',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
