import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:flutter/widgets.dart';

class ProductsBloc extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductsBloc({required this.apiRepositoryInterface});

  List<Product> productList = [];

  Future<void> loadProducts() async {
    final result = await this.apiRepositoryInterface.getProducts();
    productList = result;
    notifyListeners();
  }
}
