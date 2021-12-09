import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  late Rx<User> user = User.empty().obs;
  RxInt indexSelected = 0.obs;
  RxBool darkTheme = false.obs;

  @override
  void onReady() {
    loadUser();
    loadCurrentTheme();
    super.onReady();
  }

  void loadCurrentTheme() {
    localRepositoryInterface.isDarkMode().then((value) {
      darkTheme(value);
    });
  }

  Future<bool> updateTheme(bool isDark) async {
    await localRepositoryInterface.saveDarkMode(isDark);
    darkTheme(isDark);
    return isDark;
  }

  void loadUser() {
    localRepositoryInterface.getUser().then((value) {
      user(value);
    });
  }

  void updateIndexSelected(int index) {
    indexSelected(index);
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
