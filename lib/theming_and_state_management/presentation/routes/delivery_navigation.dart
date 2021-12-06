import 'package:deliveryapp/theming_and_state_management/presentation/home/home_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/login/login_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/splash/splash_screen.dart';
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
    ),
    GetPage(
      name: DeliveryRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: DeliveryRoutes.home,
      page: () => HomeScreen(),
    ),
  ];
}
