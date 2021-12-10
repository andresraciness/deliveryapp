import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/cart/cart_controller.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/products/products_controller.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  final controller = Get.put<ProductsController>(ProductsController(
      apiRepositoryInterface: Get.find<ApiRepositoryInterface>()));

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          'Products',
          style: TextStyle(),
        ),
      ),
      body: Obx(
        () => controller.productList.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final product = controller.productList[index];
                  return _ItemProduct(
                      product: product,
                      onTap: () => cartController.add(product));
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  _ItemProduct({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
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
              )),
              Expanded(
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
                    Text(
                      '\$${product.prince} USD',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
              DeliveryButton(
                paddingText: EdgeInsets.symmetric(vertical: 4),
                onTap: onTap,
                text: 'Add',
              )
            ],
          ),
        ));
  }
}
