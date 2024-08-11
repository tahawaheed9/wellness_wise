import 'package:flutter/foundation.dart' show immutable;

// Whether the loading screen should be closed or not...
typedef ClosedLoadingScreen = bool Function();

// Will update the text for the loading screen...
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  // Takes in the ClosedLoadingScreen as a parameter...
  final ClosedLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
