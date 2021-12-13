import 'package:deliveryapp/theming_and_state_management/presentation/getx/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/theming_and_state_management/presentation/common/theme.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {
  // final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: deliveryGradients,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: DeliveryColors.white,
              radius: 50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 70,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'DeliveryApp',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: DeliveryColors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
