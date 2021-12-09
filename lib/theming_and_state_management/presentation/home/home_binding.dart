import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/cart/cart_controller.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        localRepositoryInterface: Get.find<LocalRepositoryInterface>(),
        apiRepositoryInterface: Get.find<ApiRepositoryInterface>(),
      ),
    );

    Get.lazyPut(() => CartController());
  }
}
