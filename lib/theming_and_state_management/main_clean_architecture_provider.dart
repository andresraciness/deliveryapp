import 'package:deliveryapp/theming_and_state_management/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:provider/provider.dart';
import 'data/datasource/api_repository_impl.dart';
import 'domain/respository/api_repository.dart';
import 'presentation/provider/splash/splash_screen.dart';

import 'package:flutter/material.dart';

class MainCleanArchitectureProvider extends StatelessWidget {
  const MainCleanArchitectureProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepositoryInterface>(
          create: (_) => ApiRepositoryImpl(),
        ),
        Provider<LocalRepositoryInterface>(
          create: (_) => LocalRepositoryImpl(),
        )
      ],
      child: Builder(builder: (BuildContext newContext) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: SplashScreen.init(newContext),
        );
      }),
    );
  }
}
