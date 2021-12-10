import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theming_and_state_management/main_theming_and_state_management.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainThemingAndStateManagementApp();
  }
}
