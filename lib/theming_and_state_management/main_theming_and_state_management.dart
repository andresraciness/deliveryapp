import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'presentation/getx/routes/delivery_navigation.dart';
import 'presentation/getx/splash/splash_screen.dart';
import 'presentation/main_binding.dart';

class MainThemingAndStateManagementApp extends StatelessWidget {
  const MainThemingAndStateManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SplashScreen(),
      initialRoute: DeliveryRoutes.splash,
      getPages: DeliveryPages.pages,
      initialBinding: MainBinding(),
    );
  }
}
