import 'package:flutter/material.dart';

import '/components/primary_button.dart';

class BasicInformationForm extends StatefulWidget {
  const BasicInformationForm({super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  final _basicInformationFormKey = GlobalKey<_BasicInformationFormState>();

  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController lifestyleHabits = TextEditingController();
  final TextEditingController medicalHistory = TextEditingController();

  @override
  void dispose() {
    height.dispose();
    weight.dispose();
    lifestyleHabits.dispose();
    medicalHistory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _basicInformationFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Height & Weight Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Height Field...
                Expanded(
                  child: TextFormField(
                    controller: height,
                    keyboardType: TextInputType.number,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.height_outlined),
                      labelText: 'Height',
                      hintText: '165',
                      suffixText: 'cm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 30.0),

                // Weight Field...
                Expanded(
                  child: TextFormField(
                    controller: weight,
                    keyboardType: TextInputType.number,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.monitor_weight_outlined),
                      labelText: 'Weight',
                      hintText: '70',
                      suffixText: 'Kg',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // Lifestyle Habits Field...
            TextFormField(
              controller: lifestyleHabits,
              keyboardType: TextInputType.text,
              enableSuggestions: false,
              autocorrect: true,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Lifestyle Habits',
                alignLabelWithHint: true,
                hintText: 'Your lifestyle habits...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Medical History Field...
            TextFormField(
              controller: medicalHistory,
              keyboardType: TextInputType.text,
              enableSuggestions: false,
              autocorrect: true,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Medical History',
                alignLabelWithHint: true,
                hintText: 'Your medical history...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Save Button...
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
