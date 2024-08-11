import 'package:flutter/material.dart';

import '/services/database/database_services.dart';
import '/components/primary_button.dart';

class BasicInformationForm extends StatefulWidget {
  const BasicInformationForm({super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  late final TextEditingController _age;
  late final TextEditingController _height;
  late final TextEditingController _weight;
  late final TextEditingController _lifestyleHabits;
  late final TextEditingController _medicalHistory;

  @override
  void initState() {
    super.initState();
    _age = TextEditingController();
    _height = TextEditingController();
    _weight = TextEditingController();
    _lifestyleHabits = TextEditingController();
    _medicalHistory = TextEditingController();
  }

  @override
  void dispose() {
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    _lifestyleHabits.dispose();
    _medicalHistory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Age Field...
            TextFormField(
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_month_outlined),
                labelText: 'Age',
                hintText: '18',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30.0),

            // Height & Weight Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Height Field...
                Expanded(
                  child: TextFormField(
                    controller: _height,
                    keyboardType: TextInputType.number,
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
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
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
              controller: _lifestyleHabits,
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
              controller: _medicalHistory,
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
              onPressed: () {
                final Map<String, Object> data = {
                  'age': int.parse(_age.text),
                  'height': double.parse(_height.text),
                  'weight': double.parse(_weight.text),
                  'lifestyle-habits': _lifestyleHabits.text,
                  'medical_history': _medicalHistory.text,
                };
                addBasicInformation(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
