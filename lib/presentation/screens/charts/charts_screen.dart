import 'package:flutter/material.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: <Widget>[
            Icon(Icons.bar_chart_outlined),
            SizedBox(width: 5.0),
            Text('Charts'),
          ],
        ),
      ),
      body: Placeholder(),
    );
  }
}
