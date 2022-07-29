
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          iconSize: 40,
          icon: Assets.icons.back.image(),
          onPressed: () => Navigator.of(context).pop(),
        ));
  }
}
