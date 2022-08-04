
import 'package:flutter/material.dart';

import '../../../constants/controllers.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: authController.logout,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Cerrar Sesión",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(width: 15),
          Icon(
            Icons.exit_to_app,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}