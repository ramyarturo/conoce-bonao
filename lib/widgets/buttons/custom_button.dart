import 'package:flutter/material.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool secundary;
  final bool outlined;
  final EdgeInsets? padding;
  final double? borderRadius;
  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.secundary = false,
    this.outlined = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: secundary
            ? orangeColor
            : outlined
                ? Colors.transparent
                : null,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
        ),
      ).copyWith(
        foregroundColor: secundary
            ? MaterialStateProperty.all(blackColor)
            : outlined
                ? MaterialStateProperty.all(orangeColor)
                : null,
        side: outlined
            ? MaterialStateProperty.resolveWith<BorderSide?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) return null;
                  return const BorderSide(
                    color: orangeColor,
                    width: 2,
                  );
                  // Defer to the widget's default.
                },
              )
            : null,
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
