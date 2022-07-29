import 'package:flutter/material.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

class MainSearchBar extends StatelessWidget {
  const MainSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Buscar",
        prefixIcon: const Icon(
          Icons.search,
          color: orangeColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
