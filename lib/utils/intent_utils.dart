import 'package:conoce_bonao/utils/snackbar_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntentUtils {
  static openUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      SnackbarUtils.showSnackbar(
        message: "Error al abril enlace",
      );
    }
  }

  static openMap({required String address}) async {
    String encodedAddress = Uri.encodeComponent(address);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";

    if (await canLaunchUrlString(googleMapUrl)) {
      await launchUrlString(googleMapUrl);
    } else {
      SnackbarUtils.showSnackbar(
        message: "Error al mostrar la dirección",
      );
    }
  }
}
