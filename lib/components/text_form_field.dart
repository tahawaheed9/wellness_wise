import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool autoCorrect;
  final bool enableSuggestions;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final Widget? prefixIcon;
  final String? labelText;
  final bool? alignLabelWithHint;
  final String? hintText;
  final Widget? suffixIcon;
  final String? suffixText;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.autoCorrect,
    required this.enableSuggestions,
    required this.keyboardType,
    required this.obscureText,
    required this.maxLines,
    required this.prefixIcon,
    required this.labelText,
    required this.alignLabelWithHint,
    required this.hintText,
    required this.suffixIcon,
    required this.suffixText,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autocorrect: widget.autoCorrect,
      enableSuggestions: widget.enableSuggestions,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        alignLabelWithHint: widget.alignLabelWithHint,
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        suffixText: widget.suffixText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
