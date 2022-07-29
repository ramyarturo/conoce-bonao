import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtils {
  static showOkDialog({String? title, required String message}) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title ?? "Aviso", textAlign: TextAlign.center),
          content: Text(message, textAlign: TextAlign.center),
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text("Aceptar"),
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
