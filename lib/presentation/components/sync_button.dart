import 'package:flutter/material.dart';

class SyncButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SyncButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      width: 300.0,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.sync_outlined),
            const SizedBox(width: 10.0),
            Text(
              'Sync Health Data',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
