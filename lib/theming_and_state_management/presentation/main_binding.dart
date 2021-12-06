import 'package:deliveryapp/theming_and_state_management/data/datasource/api_repository_impl.dart';
import 'package:deliveryapp/theming_and_state_management/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Trabaja en base a interfaces la inyección
    
    Get.lazyPut<LocalRepositoryInterface>(() {
      return LocalRepositoryImpl();
    });
    Get.lazyPut<ApiRepositoryInterface>(() {
      return ApiRepositoryImpl();
    });
  }
}
