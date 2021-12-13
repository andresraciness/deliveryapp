import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:flutter/widgets.dart';

class SplashBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  // void validateTheme() async {
  //   final isDark = await localRepositoryInterface?.isDarkMode();

  //   if (isDark != null) {
  //     Get.changeTheme(isDark ? darkTheme : lightTheme);
  //   } else {
  //     Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
  //   }
  // }

  Future<bool> validateSession() async {
    final token = await localRepositoryInterface.getToken();

    if (token != null) {
      final user = await apiRepositoryInterface.getUserFromToken(token);
      await localRepositoryInterface.saveUser(user);
      return true;
    } else {
      return false;
    }
  }
}
