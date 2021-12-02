import 'package:deliveryapp/theming_and_state_management/data/in_memory_products.dart';
import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            final product = products[index];
            return _ItemProduct(product: product);
          }),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final Product product;

  const _ItemProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

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
                onTap: () {},
                text: 'Add',
              )
            ],
          ),
        ));
  }
}
