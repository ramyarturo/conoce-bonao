import 'package:flutter/material.dart';

class AnimatedNumber extends StatelessWidget {
  final num number;
  final Color? color;
  final Widget Function(num number)? builder;

  const AnimatedNumber({
    super.key,
    required this.number,
    this.builder,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<num>(
      tween: Tween(begin: 0, end: number),
      duration: const Duration(milliseconds: 1800),
      curve: Curves.decelerate,
      builder: (_, value, __) {
        return builder?.call(value) ?? Text(
          value.toStringAsFixed(number is int ? 0 : 1),
          style: TextStyle(
            color: color,
          ),
        );
      },
    );
  }
}
