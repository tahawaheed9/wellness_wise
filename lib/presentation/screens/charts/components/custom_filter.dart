import 'package:flutter/material.dart';

const List<String> _filterList = <String>[
  'All Time',
  'Past 24 Hours',
  'Past Week',
  'Past Month',
];

class CustomFilter extends StatefulWidget {
  const CustomFilter({super.key});

  @override
  State<CustomFilter> createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  String value = _filterList.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.filter_alt_outlined),
        const SizedBox(width: 10.0),
        DropdownButton<String>(
          value: value,
          items: _filterList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? selectedValue) {
            setState(() {
              value = selectedValue!;
            });
          },
        ),
      ],
    );
  }
}
