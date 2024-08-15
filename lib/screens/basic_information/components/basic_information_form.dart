import 'package:flutter/material.dart';

import '/services/database/data_services.dart';
import '/components/primary_button.dart';

class BasicInformationForm extends StatefulWidget {
  const BasicInformationForm({super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  final _basicInformationFormKey = GlobalKey<FormState>();

  late final DatabaseServices _db = DatabaseServices();
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
      key: _basicInformationFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Height & Weight Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Age Field...
                Expanded(
                  child: TextFormField(
                    controller: _age,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                // Height Field...
                Expanded(
                  child: TextFormField(
                    controller: _height,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      labelText: 'Height',
                      suffixText: 'cm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),

                // Weight Field...
                Expanded(
                  child: TextFormField(
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
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
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Lifestyle Habits',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30.0),

            // Medical History Field...
            TextFormField(
              controller: _medicalHistory,
              maxLines: 3,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Medical History',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30.0),

            // Save Button...
            PrimaryButton(
              text: 'Save Information',
              onPressed: () {
                if (_basicInformationFormKey.currentState!.validate()) {
                  Map<String, Object?> data = {
                    'age': int.parse(_age.text),
                    'height': '${double.parse(_height.text)} cm',
                    'weight': '${double.parse(_weight.text)} Kg',
                    'lifestyle-habits': _lifestyleHabits.text,
                    'medical-history': _medicalHistory.text,
                  };
                  _db.updateBasicInformation(data);
                  ScaffoldMessenger.of(_basicInformationFormKey.currentContext!)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Successfully updated.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String? _validateForm(value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }
}
