import 'package:get/get.dart';

class SnackbarUtils {
  static showSnackbar({String title = "", String message = ""}) {
    Get.rawSnackbar(
      title: title,
      message: message,
      duration: 2.seconds,
    );
  }
}
