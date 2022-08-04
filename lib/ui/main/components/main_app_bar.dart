import 'package:flutter/material.dart';
import 'package:conoce_bonao/constants/controllers.dart';

import 'app_bar_delegate.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = userController.currentUser.value?.fullName ?? "";
    return SliverPersistentHeader(
      delegate: AppBarDelegate(
        title: "Bienvenido, $userName",
        actions: [],
      ),
    );
  }
}
