import 'package:conoce_bonao/utils/snackbar_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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

  static openNavigationMap({required LatLng latLng}) async {
    var uri = Uri.parse("google.navigation:q=${latLng.latitude},${latLng.longitude}&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      SnackbarUtils.showSnackbar(
        message: "Error al mostrar la dirección",
      );
    }
  }
}
