import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  // manejo de dependencias
  // inyectando dependencias
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        apiRepositoryInterface: Get.find<ApiRepositoryInterface>(),
        localRepositoryInterface: Get.find<LocalRepositoryInterface>()));
  }
}
