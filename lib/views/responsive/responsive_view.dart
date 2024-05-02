import 'package:flutter/material.dart';

class ResponsiveView extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  static const _mobileWidth = 500;

  const ResponsiveView({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _mobileWidth) {
          return mobile;
        } else {
          return tablet;
        }
      },
    );
  }
}
