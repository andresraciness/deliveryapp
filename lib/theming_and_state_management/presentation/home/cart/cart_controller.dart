import 'package:deliveryapp/theming_and_state_management/domain/models/product_cart.dart';
import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<ProductCart> cartList = <ProductCart>[].obs;
  RxInt totalItem = 0.obs;

  void add(Product product) {
    final temp = List<ProductCart>.from(cartList.value);

    bool found = false;
    for (var p in temp) {
      if (p.product.name == product.name) {
        p.quantity += 1;
        found = true;
        break;
      }
    }

    if (!found) temp.add(ProductCart(product: product));
    cartList.value = List<ProductCart>.from(temp);
    final total = temp.fold<int>(
        0, (previousValue, element) => element.quantity + previousValue);

    totalItem(total);
  }

  void remove(Product product) {}
}
