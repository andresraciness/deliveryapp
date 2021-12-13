import 'package:deliveryapp/theming_and_state_management/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/provider/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      )..loadUser(),
      builder: (_, __) => HomeScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: IndexedStack(
              index: bloc.indexSelected,
              children: [
                // ProductsScreen(),
                const Placeholder(),

                const Placeholder(),
                const Placeholder(),
                // CartScreen(
                //   onShopping: () => bloc.updateIndexSelected(0),
                // ),
                const Placeholder(),
                const Placeholder(),
                // ProfileScreen(),
              ],
            ),
          ),
          _DeliveryNavigatorBar(
              index: bloc.indexSelected,
              onIndexSelected: (index) {
                bloc.updateIndexSelected(index);
              }),
        ],
      ),
    );
  }
}

class _DeliveryNavigatorBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  _DeliveryNavigatorBar({
    Key? key,
    required this.index,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    final user = bloc.user;

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
                    // Obx(
                    //   () => Positioned(
                    //       right: 0,
                    //       child: cartController.totalItem.value == 0
                    //           ? SizedBox.shrink()
                    //           : CircleAvatar(
                    //               radius: 10,
                    //               backgroundColor: Colors.pinkAccent,
                    //               child: Text(cartController.totalItem.value
                    //                   .toString()),
                    //             )),
                    // )
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
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(
                    user?.image ?? no_image,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
