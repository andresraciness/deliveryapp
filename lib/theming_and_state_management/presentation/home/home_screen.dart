import 'package:deliveryapp/theming_and_state_management/presentation/home/cart/cart_controller.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';
import 'cart/cart_screen.dart';
import 'products/products_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.indexSelected.value,
                children: [
                  ProductsScreen(),
                  const Placeholder(),
                  CartScreen(
                    onShopping: () {
                      controller.updateIndexSelected(0);
                    },
                  ),
                  const Placeholder(),
                  ProfileScreen(),
                ],
              ),
            ),
          ),
          Obx(
            () => _DeliveryNavigatorBar(
                index: controller.indexSelected.value,
                onIndexSelected: (index) {
                  controller.updateIndexSelected(index);
                }),
          )
        ],
      ),
    );
  }
}

class _DeliveryNavigatorBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;
  final controller = Get.find<HomeController>();
  final cartController = Get.find<CartController>();

  _DeliveryNavigatorBar({
    Key? key,
    required this.index,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Theme.of(context).bottomAppBarColor,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 26,
                    color: index == 0
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                  onPressed: () => onIndexSelected(0),
                ),
              ),
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.storefront_sharp,
                    color: index == 1
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                  onPressed: () => onIndexSelected(1),
                ),
              ),
              Material(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: DeliveryColors.purple,
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_basket_outlined,
                          size: 28,
                          color: index == 2
                              ? DeliveryColors.green
                              : DeliveryColors.white,
                        ),
                        onPressed: () => onIndexSelected(2),
                      ),
                    ),
                    Obx(
                      () => Positioned(
                          right: 0,
                          child: cartController.totalItem.value == 0
                              ? SizedBox.shrink()
                              : CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.pinkAccent,
                                  child: Text(cartController.totalItem.value
                                      .toString()),
                                )),
                    )
                  ],
                ),
              ),
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: index == 3
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                  onPressed: () => onIndexSelected(3),
                ),
              ),
              InkWell(
                onTap: () => onIndexSelected(4),
                child: Obx(() {
                  final user = controller.user.value;
                  return user.image == null
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage(user.image ?? ''),
                        );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
