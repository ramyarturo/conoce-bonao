import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/models/user.dart';
import 'package:conoce_bonao/widgets/loading_widget.dart';

import '../constants/repositories.dart';
import '../utils/snackbar_utils.dart';

class SignUpController extends GetxController {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final province = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    showLoading();
    UserModel user = _buildUser();
    final result = await authRepository.signUp(user);
    hideLoading();
    if (result.isError) {
      SnackbarUtils.showSnackbar(title: "Error", message: result.getErrorOr());
    }
  }

  UserModel _buildUser() => UserModel(
        fullName: fullName.text,
        email: email.text,
        phone: phone.text,
        province: province.text,
        password: password.text,
      );
  _disposeControllers() {
    fullName.dispose();
    email.dispose();
    phone.dispose();
    province.dispose();
    password.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }
}
