import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Widget child;
  final double size;

  const CircleIcon({super.key, required this.child, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffe0e0e0),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
