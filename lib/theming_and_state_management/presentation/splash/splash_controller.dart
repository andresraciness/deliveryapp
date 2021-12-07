import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/routes/delivery_navigation.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface? localRepositoryInterface;
  final ApiRepositoryInterface? apiRepositoryInterface;

  SplashController({
    this.localRepositoryInterface,
    this.apiRepositoryInterface,
  });

  @override
  void onInit() {
    validateTheme();
    super.onInit();
  }

  @override
  void onReady() {
    validateSession();
    super.onReady();
  }

  void validateTheme() async {
    final isDark = await localRepositoryInterface?.isDarkMode();

    if (isDark != null) {
      Get.changeTheme(isDark ? darkTheme : lightTheme);
    } else {
      Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
    }
  }

  void validateSession() async {
    final token = await localRepositoryInterface?.getToken();

    if (token != null) {
      final user = await apiRepositoryInterface?.getUserFromToken(token);
      await localRepositoryInterface?.saveUser(user!);

      Get.offNamed(DeliveryRoutes.home);
    } else {
      Get.offNamed(DeliveryRoutes.login);
    }
  }
}
