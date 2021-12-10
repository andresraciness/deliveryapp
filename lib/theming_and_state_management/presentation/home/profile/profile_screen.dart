import 'package:deliveryapp/theming_and_state_management/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/home/home_controller.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/routes/delivery_navigation.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  Future<void> logout() async {
    try {
      await controller.logOut();
      Get.offAllNamed(DeliveryRoutes.login);
    } on LogoutException catch (_) {
      Get.snackbar('Error', 'Logout Error');
    }
  }

  void onThemeUpdated(bool isDark) async {
    await controller.updateTheme(isDark);
    Get.changeTheme(isDark ? darkTheme : lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: Text('Profile'),
        leading: SizedBox(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DeliveryColors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(user.image ?? no_image),
                      radius: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.name ?? 'Username',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Card(
                    elevation: 5,
                    color: Theme.of(context).canvasColor,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: DeliveryColors.green),
                          ),
                          Text(
                            '${user.username}@email.com',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Obx(
                            () => SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Dark Mode',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onChanged: onThemeUpdated,
                                value: controller.darkTheme.value),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        primary: DeliveryColors.purple),
                    onPressed: logout,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Log Out'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
