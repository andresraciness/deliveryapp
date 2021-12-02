import 'package:flutter/material.dart';

import '../theme.dart';
import 'cart/cart_screen.dart';
import 'products/products_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: IndexedStack(
              index: currenIndex,
              children: [
                ProductsScreen(),
                Text('CurrentIndex 2: $currenIndex'),
                CartScreen(
                  onShopping: () {
                    setState(() {
                      currenIndex = 0;
                    });
                  },
                ),
                Text('CurrentIndex 4: $currenIndex'),
                ProfileScreen(),
              ],
            ),
          ),
          _DeliveryNavigatorBar(
              index: currenIndex,
              onIndexSelected: (index) {
                setState(() {
                  currenIndex = index;
                });
              })
        ],
      ),
    );
  }
}

class _DeliveryNavigatorBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  const _DeliveryNavigatorBar({
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
                child: CircleAvatar(
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
                child: CircleAvatar(
                  // child: Icon(Icons.person_outline),
                  radius: 15,
                  backgroundColor: Colors.blue,
                ),
                onTap: () => onIndexSelected(4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
