import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/request/login_request.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum LoginState {
  loading,
  initial,
}

class LoginController extends GetxController {
  final LocalRepositoryInterface? localRepositoryInterface;
  final ApiRepositoryInterface? apiRepositoryInterface;

  LoginController({
    this.localRepositoryInterface,
    this.apiRepositoryInterface,
  });

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var loginState = LoginState.initial.obs;

  @override
  void onInit() {
    validateTheme();
    super.onInit();
  }

  Future<bool> login() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    try {
      loginState(LoginState.loading);
      final loginResponse = await apiRepositoryInterface!.login(
        LoginRequest(username: username, password: password),
      );

      await localRepositoryInterface?.saveToken(loginResponse.token);
      await localRepositoryInterface?.saveUser(loginResponse.user);

      return true;
    } on AuthException catch (_) {
      loginState(LoginState.initial);
      return false;
    }
  }

  void validateTheme() async {
    final isDark = await localRepositoryInterface?.isDarkMode();

    if (isDark != null) {
      Get.changeTheme(isDark ? darkTheme : lightTheme);
    } else {
      Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
    }
  }
}
