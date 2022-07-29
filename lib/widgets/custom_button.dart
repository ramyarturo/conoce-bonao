import 'package:flutter/material.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool secundary;
  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.secundary = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            backgroundColor: secundary ? MaterialStateProperty.all(orangeColor) : null,
            foregroundColor: secundary ? MaterialStateProperty.all(blackColor) : null,
          ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            if (icon != null) ...[
              const SizedBox(width: 10),
              Icon(icon),
            ]
          ],
        ),
      ),
    );
  }
}
