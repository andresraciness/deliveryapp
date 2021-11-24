import 'package:deliveryapp/theming_and_state_management/presentation/login/login_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/splash/splash_screen.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainThemingAndStateManagementApp extends StatelessWidget {
  const MainThemingAndStateManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderLight = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: DeliveryColors.veryLightGrey,
        width: 2,
        style: BorderStyle.solid,
      ),
    );
    final _borderDark = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: DeliveryColors.grey,
        width: 2,
        style: BorderStyle.solid,
      ),
    );

    final lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: DeliveryColors.white,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
            headline6: TextStyle(
          fontSize: 20,
          color: DeliveryColors.purple,
          fontWeight: FontWeight.bold
        )),
      ),
      canvasColor: DeliveryColors.white,
      accentColor: DeliveryColors.purple,
      bottomAppBarColor: DeliveryColors.veryLightGrey,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors.purple,
        displayColor: DeliveryColors.purple,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: _borderLight,
        enabledBorder: _borderLight,
        focusedBorder: _borderLight,
        contentPadding: EdgeInsets.zero,
        labelStyle: TextStyle(color: DeliveryColors.purple),
        hintStyle: GoogleFonts.poppins(
          color: DeliveryColors.lightGrey,
          fontSize: 10,
        ),
      ),
      iconTheme: IconThemeData(
        color: DeliveryColors.purple,
      ),
    );

    final darkTheme = ThemeData(
     appBarTheme: AppBarTheme(
        centerTitle: true,
        color: DeliveryColors.purple,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
            headline6: TextStyle(
          fontSize: 20,
          color: DeliveryColors.white,
          fontWeight: FontWeight.bold
        )),
      ),
      bottomAppBarColor: Colors.transparent,
      canvasColor: DeliveryColors.grey,
      scaffoldBackgroundColor: DeliveryColors.dark,
      accentColor: DeliveryColors.white,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors.green,
        displayColor: DeliveryColors.green,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: _borderDark,
        enabledBorder: _borderDark,
        focusedBorder: _borderDark,
        contentPadding: EdgeInsets.zero,
        labelStyle: TextStyle(color: DeliveryColors.white),
        fillColor:
            DeliveryColors.grey, // Cambia el color del textField internamente
        filled: true, // Activa el color intenro de arriba
        hintStyle: GoogleFonts.poppins(
          color: DeliveryColors.white,
          fontSize: 10,
        ),
      ),
      iconTheme: IconThemeData(
        color: DeliveryColors.white,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: LoginScreen(),
    );
  }
}
