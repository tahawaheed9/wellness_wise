import 'package:flutter/material.dart';

import '../constants/routes.dart';

pushLoginScreen(BuildContext context) {
  Navigator.of(context).pushNamed(loginScreenRoute);
}

pushRegisterScreen(BuildContext context) {
  Navigator.of(context).pushNamed(registerScreenRoute);
}

pushResetPasswordScreen(BuildContext context) {
  Navigator.of(context).pushNamed(resetPasswordScreenRoute);
}
