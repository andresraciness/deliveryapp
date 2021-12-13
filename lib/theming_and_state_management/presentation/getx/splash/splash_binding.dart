import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/getx/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(
        apiRepositoryInterface: Get.find<ApiRepositoryInterface>(),
        localRepositoryInterface: Get.find<LocalRepositoryInterface>(),
      ),
    );
  }
}
