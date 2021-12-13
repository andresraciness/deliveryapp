import 'package:deliveryapp/theming_and_state_management/presentation/getx/home/home_binding.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/getx/home/home_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/getx/login/login_binding.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/getx/login/login_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/getx/splash/splash_binding.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/getx/splash/splash_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/main_binding.dart';
import 'package:get/route_manager.dart';

class DeliveryRoutes {
  static final String splash = '/splash';
  static final String login = '/login';
  static final String home = '/home';
}

class DeliveryPages {
  static final pages = [
    GetPage(
      name: DeliveryRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: DeliveryRoutes.login,
      page: () => LoginScreen(),
      bindings: [
        MainBinding(),
        LoginBinding(),
      ],
    ),
    GetPage(name: DeliveryRoutes.home, page: () => HomeScreen(),
        // binding: HomeBinding(),
        bindings: [
          MainBinding(),
          HomeBinding(),
        ]),
  ];
}
