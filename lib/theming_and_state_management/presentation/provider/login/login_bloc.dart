import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/request/login_request.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:flutter/widgets.dart';

enum LoginState {
  loading,
  initial,
}

class LoginBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  LoginBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var loginState = LoginState.initial;

  Future<bool> login() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    try {
      loginState = LoginState.loading;
      notifyListeners();

      final loginResponse = await apiRepositoryInterface.login(
        LoginRequest(username: username, password: password),
      );

      await localRepositoryInterface.saveToken(loginResponse.token);
      await localRepositoryInterface.saveUser(loginResponse.user);
      loginState = LoginState.initial;
      notifyListeners();

      return true;
    } on AuthException catch (_) {
      loginState = LoginState.initial;
      notifyListeners();
      return false;
    }
  }

  void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();

    // if (isDark != null) {
    //   Get.changeTheme(isDark ? darkTheme : lightTheme);
    // } else {
    //   Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
    // }
  }
}
