import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/delivery_button.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/provider/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_bloc.dart';

const logoSize = 45.0;

class LoginScreen extends StatelessWidget {
  LoginScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (_, __) => LoginScreen._(),
    );
  }

  void login(BuildContext context) async {
    try {
      final loginBloc = Provider.of<LoginBloc>(context, listen: false);
      final result = await loginBloc.login();
      if (result) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => HomeScreen.init(context),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.transparent,
            content: Text('Error login incorrect.'),
          ),
        );
      }
    } on AuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final moreSize = 50.0;

    final loginBloc = Provider.of<LoginBloc>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Positioned(
                      left: -moreSize / 2,
                      right: -moreSize / 2,
                      bottom: logoSize,
                      height: width + moreSize,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.5, 1.0],
                            colors: deliveryGradients,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(size.width / 2),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).canvasColor,
                        radius: logoSize,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.person_outline,
                            size: logoSize,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Username',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle
                                    ?.color,
                              ),
                        ),
                        TextField(
                          controller: loginBloc.usernameTextController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Password',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle
                                    ?.color,
                              ),
                        ),
                        TextField(
                          controller: loginBloc.passwordTextController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Theme.of(context).iconTheme.color,
                              size: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: DeliveryButton(
                  text: 'Login',
                  onTap: () => login(context),
                ),
              )
            ],
          ),
          Positioned.fill(
              child: (loginBloc.loginState == LoginState.loading)
                  ? Container(
                      color: Colors.black26,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
