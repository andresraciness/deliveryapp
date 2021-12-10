import 'package:deliveryapp/theming_and_state_management/domain/models/product_cart.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/cart/cart_controller.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends GetWidget<CartController> {
  const CartScreen({
    Key? key,
    required this.onShopping,
  }) : super(key: key);

  final VoidCallback onShopping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Shopping Cart'),
      ),
      body: Obx(() {
        return controller.totalItem.value == 0
            ? _EmptyCart(onShopping: onShopping)
            : _FullCart();
      }),
    );
  }
}

class _FullCart extends GetWidget<CartController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Obx(
              () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 230,
                  itemCount: controller.cartList.length,
                  itemBuilder: (context, index) {
                    final productCart = controller.cartList[index];
                    return _ShoppingCartProduct(
                        productCart: productCart,
                        onDelete: () => controller.deleteProduct(productCart),
                        onIncrement: () => controller.increment(productCart),
                        onDecrement: () => controller.decrement(productCart));
                  }),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Theme.of(context).accentColor,
                              ),
                        ),
                        Text(
                          '\$0 USD',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Theme.of(context).accentColor,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Theme.of(context).accentColor,
                              ),
                        ),
                        Text(
                          'Free',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Theme.of(context).accentColor,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Obx(
                          () {
                            final total =
                                controller.totalPrice.value.toStringAsFixed(2);
                            return Text(
                              '\$$total USD',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    DeliveryButton(onTap: () {}, text: 'Checkout')
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  final VoidCallback onShopping;

  const _EmptyCart({Key? key, required this.onShopping}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.sentiment_dissatisfied,
          color: DeliveryColors.green,
          size: 150,
        ),
        const SizedBox(height: 10),
        Text(
          'There are no products',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                primary: DeliveryColors.purple),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Go Shopping'),
            ),
            onPressed: onShopping,
          ),
        ),
      ],
    );
  }
}

class _ShoppingCartProduct extends StatelessWidget {
  final ProductCart productCart;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _ShoppingCartProduct({
    Key? key,
    required this.productCart,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productCart.product;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(product.name),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.overline?.copyWith(
                                color: DeliveryColors.lightGrey,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: onDecrement,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: DeliveryColors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: DeliveryColors.purple,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('${productCart.quantity}'),
                              ),
                              InkWell(
                                onTap: onIncrement,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: DeliveryColors.purple,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: DeliveryColors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${product.prince}',
                                style: TextStyle(color: DeliveryColors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: onDelete,
              child: CircleAvatar(
                radius: 17,
                backgroundColor: DeliveryColors.pink,
                child: Icon(
                  Icons.delete_outline,
                  color: DeliveryColors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
