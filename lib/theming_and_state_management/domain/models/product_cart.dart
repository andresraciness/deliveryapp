import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';

class ProductCart {
  ProductCart({required this.product, this.quantity = 1});

  final Product product;
  int quantity;
}
