import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ApiRepositoryInterface? apiRepositoryInterface;

  ProductsController({this.apiRepositoryInterface});

  RxList<Product> productList = <Product>[].obs;

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  Future<void> loadProducts() async {
    final result = await this.apiRepositoryInterface!.getProducts();
    productList.value = result;
  }
}
