import 'package:flutter/material.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  String? _selectedValue;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      hint: const Text('Gender'),
      alignment: Alignment.center,
      decoration: InputDecoration(
        prefixIcon: _selectedValue == null
            ? const Icon(Icons.person_outline)
            : _selectedValue == 'male'
                ? const Icon(Icons.male)
                : const Icon(Icons.female),
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
          gender = value;
        });
      },
      items: const [
        DropdownMenuItem(
          value: 'male',
          child: Text('Male'),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text('Female'),
        ),
      ],
    );
  }
}
