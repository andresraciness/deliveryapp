import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:flutter/widgets.dart';

class HomeBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  User? user;
  int indexSelected = 0;

  // Future<bool> updateTheme(bool isDark) async {
  //   await localRepositoryInterface.saveDarkMode(isDark);
  //   darkTheme(isDark);
  //   return isDark;
  // }

  Future<void> loadUser() async {
    user = (await localRepositoryInterface.getUser())!;
    notifyListeners();
  }

  void updateIndexSelected(int index) {
    indexSelected = index;
    notifyListeners();
  }

  // Future<void> logOut() async {
  //   final token = await localRepositoryInterface.getToken();

  //   if (token != null) {
  //     await apiRepositoryInterface.logout(token);
  //     await localRepositoryInterface.clearAllData();
  //   } else {
  //     throw LogoutException();
  //   }
  // }
}
