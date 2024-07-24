import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return MaterialButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      minWidth: 200,
      padding: const EdgeInsets.all(16.0 * 0.75),
      onPressed: onPressed,
      child: Text(
        text,
        style: size < 500
            ? Theme.of(context).textTheme.bodyLarge
            : Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 25),
      ),
    );
  }
}
