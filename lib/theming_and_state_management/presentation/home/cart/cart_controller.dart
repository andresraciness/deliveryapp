import 'package:deliveryapp/theming_and_state_management/domain/models/product_cart.dart';
import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<ProductCart> cartList = <ProductCart>[].obs;
  RxInt totalItem = 0.obs;
  RxDouble totalPrice = 0.0.obs;

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

    calculateTotals(temp);
  }

  void increment(ProductCart product) {
    product.quantity += 1;
    // para que crear una nueva lista y que se actualice
    cartList.value = List<ProductCart>.from(cartList.value);
    calculateTotals(cartList.value);
  }

  void decrement(ProductCart product) {
    if (product.quantity > 1) {
      product.quantity -= 1;
      // para que crear una nueva lista y que se actualice
      cartList.value = List<ProductCart>.from(cartList.value);
      calculateTotals(cartList.value);
    }
  }

  void calculateTotals(List<ProductCart> temp) {
    final total = temp.fold<int>(
        0, (previousValue, element) => element.quantity + previousValue);

    final totalPriceTemp = temp.fold<double>(
        0.0,
        (previousValue, element) =>
            (element.product.prince * element.quantity) + previousValue);

    totalItem(total);
    totalPrice(totalPriceTemp);
  }

  void deleteProduct(ProductCart productCart) {
    cartList.remove(productCart);
    calculateTotals(cartList.value);
  }
}
