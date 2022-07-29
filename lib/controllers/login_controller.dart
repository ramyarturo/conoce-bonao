import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/utils/snackbar_utils.dart';
import 'package:conoce_bonao/widgets/loading_widget.dart';

import '../constants/repositories.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    showLoading();

    final result = await authRepository.login(
      email: email.text,
      password: password.text,
    );
    hideLoading();
    if (result.isError) {
      SnackbarUtils.showSnackbar(title: "Error al iniciar sesion", message: result.getErrorOr());
    }
  }

  _disposeControllers() {
    email.dispose();
    password.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    _disposeControllers();
  }
}
