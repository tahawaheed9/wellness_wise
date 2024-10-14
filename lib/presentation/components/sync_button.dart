import 'package:flutter/material.dart';

class SyncButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SyncButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize:  const WidgetStatePropertyAll<Size>(
          Size.fromHeight(55.0),
        ),
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
        children: <Widget>[
          const Icon(Icons.sync_outlined),
          const SizedBox(width: 10.0),
          Text(
            'Sync data (Google Fit)',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
