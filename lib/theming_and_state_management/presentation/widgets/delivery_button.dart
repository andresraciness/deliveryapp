import 'package:deliveryapp/theming_and_state_management/presentation/theme.dart';
import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final EdgeInsets paddingText;

  const DeliveryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.paddingText = const EdgeInsets.all(14.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: deliveryGradients,
          ),
        ),
        child: Padding(
          padding: paddingText,
          child: Text(text,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
