import 'package:deliveryapp/theming_and_state_management/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/provider/login/login_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/provider/home/home_bloc.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/provider/home/profile/profile_bloc.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/provider/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (_, __) => ProfileScreen._(),
    );
  }

  Future<void> logout(BuildContext context) async {
    try {
      final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
      await profileBloc.logOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen.init(context)),
        (route) => false,
      );
    } on LogoutException catch (_) {
      print(_);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen.init(context)),
        (route) => false,
      );
      print('Exception capture');
    }
  }

  void onThemeUpdated(BuildContext context, bool isDark) {
    final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    profileBloc.updateTheme(isDark);
    final mainBloc = context.read<MainBloc>();
    mainBloc.updateTheme(isDark ? darkTheme : lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    final profileBloc = Provider.of<ProfileBloc>(context);

    final user = homeBloc.user;

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
                      backgroundImage: AssetImage(user?.image ?? no_image),
                      radius: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.name ?? 'Username',
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
                            '${user?.username ?? "email"}@email.com',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (change) =>
                                  onThemeUpdated(context, change),
                              value: profileBloc.isDark),
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
                    onPressed: () => logout(context),
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
