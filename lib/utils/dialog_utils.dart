import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DialogUtils {
  static Future _baseDialog({
    required String title,
    required String message,
    String? okMessage,
    String? cancelMessage,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (cancelMessage != null)
                TextButton(
                  child: Text(cancelMessage.toUpperCase()),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).textTheme.button!.color,
                  ),
                  onPressed: () => Get.back(result: false),
                ),
              if (okMessage != null)
                TextButton(
                  child: Text(okMessage.toUpperCase()),
                  onPressed: () => Get.back(result: true),
                )
            ],
          ),
        );
      },
    );
  }

  static Future showOkDialog({
    required String message,
    String okMessage = "Aceptar",
  }) {
    return _baseDialog(
      title: "Aviso",
      message: message,
      okMessage: okMessage,
    );
  }

  static Future showOkCancelDialog({
    required String title,
    required String message,
    String okMessage = "",
    String cancelMessage = "",
  }) {
    return _baseDialog(
      title: title,
      message: message,
      okMessage: okMessage,
      cancelMessage: cancelMessage,
    );
  }

  static void showLoadingDialog({String message = ""}) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: message.isNotEmpty
              ? _alertDialog(message)
              : Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 24,
                    ),
                    color: Colors.white,
                    child: const CircularProgressIndicator(),
                  ),
                ),
        );
      },
      barrierDismissible: false,
    );
  }

  static AlertDialog _alertDialog(String message) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message.isNotEmpty) ...[
              const SizedBox(height: 15),
              Text(message),
            ],
          ],
        ),
      );

  static void hideLoadingDialog() {
    Get.back();
  }
}
