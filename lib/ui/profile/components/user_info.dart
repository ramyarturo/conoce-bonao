

import 'package:flutter/material.dart';

import '../../../models/user.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(userModel.email),
        const SizedBox(width: 15),
        const Text("|"),
        const SizedBox(width: 15),
        Text(userModel.province),
      ],
    );
  }
}
