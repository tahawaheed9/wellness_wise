import 'package:flutter/material.dart';

import '../../../constants/routes.dart';

pushLoginView(BuildContext context) {
  Navigator.of(context).pushNamed(loginViewRoute);
}

pushRegisterView(BuildContext context) {
  Navigator.of(context)
      .pushNamed(registerViewRoute);
}
