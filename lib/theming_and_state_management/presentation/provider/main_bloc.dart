import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;

  MainBloc({required this.localRepositoryInterface});

  ThemeData? currentTheme;

  Future<void> loadTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode() ?? false;
    updateTheme(isDark ? darkTheme : lightTheme);
  }

  void updateTheme(ThemeData theme) {
    currentTheme = theme;
    notifyListeners();
  }
}
