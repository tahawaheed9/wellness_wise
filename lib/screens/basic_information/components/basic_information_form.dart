import 'package:flutter/material.dart';

import '/components/text_form_field.dart';
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
            MyTextFormField(
              controller: _age,
              autoCorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              obscureText: false,
              maxLines: 1,
              prefixIcon: const Icon(Icons.calendar_month_outlined),
              labelText: 'Age',
              alignLabelWithHint: null,
              hintText: '0',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

            // Height & Weight Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Height Field...
                Expanded(
                  child: MyTextFormField(
                    controller: _height,
                    autoCorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.height_outlined),
                    labelText: 'Height',
                    alignLabelWithHint: null,
                    hintText: '165',
                    suffixIcon: null,
                    suffixText: 'cm',
                  ),
                ),
                const SizedBox(width: 30.0),

                // Weight Field...
                Expanded(
                  child: MyTextFormField(
                    controller: _weight,
                    autoCorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.monitor_weight_outlined),
                    labelText: 'Weight',
                    alignLabelWithHint: null,
                    hintText: '70',
                    suffixIcon: null,
                    suffixText: 'Kg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // Lifestyle Habits Field...
            MyTextFormField(
              controller: _lifestyleHabits,
              autoCorrect: true,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              maxLines: 3,
              prefixIcon: null,
              labelText: 'Lifestyle Habits',
              alignLabelWithHint: true,
              hintText: 'Your lifestyle habits...',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

            // Medical History Field...
            MyTextFormField(
              controller: _medicalHistory,
              autoCorrect: true,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              maxLines: 3,
              prefixIcon: null,
              labelText: 'Medical History',
              alignLabelWithHint: true,
              hintText: 'Your medical history...',
              suffixIcon: null,
              suffixText: null,
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
