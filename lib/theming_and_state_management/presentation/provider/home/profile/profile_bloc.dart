import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:flutter/material.dart';

class ProfileBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  ProfileBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  bool isDark = false;

  Future<void> loadTheme() async {
    isDark = await localRepositoryInterface.isDarkMode() ?? false;
    notifyListeners();
  }

  void updateTheme(bool isDarkValue) async {
    await localRepositoryInterface.saveDarkMode(isDarkValue);
    isDark = isDarkValue;
    notifyListeners();
  }

  Future<void> logOut() async {
    final token = await localRepositoryInterface.getToken();

    if (token != null) {
      await apiRepositoryInterface.logout(token);
      await localRepositoryInterface.clearAllData();
    } else {
      throw LogoutException();
    }
  }
}
