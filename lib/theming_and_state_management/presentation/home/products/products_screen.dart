import 'package:deliveryapp/theming_and_state_management/data/in_memory_products.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: GridView.builder(
          itemCount: products.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final product = products[index];
            return _ItemProduct(product: product);
          }),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final product;
  const _ItemProduct({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Image.asset(product.image)
      ],),
    ));
  }
}
