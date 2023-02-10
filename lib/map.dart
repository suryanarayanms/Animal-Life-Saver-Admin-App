import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    Geolocator.isLocationServiceEnabled();
    Geolocator.checkPermission();
    print(Geolocator.checkPermission());
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
    print(latitude);
    print(longitude);

    if (await canLaunch(googleURL)) {
      await launch(googleURL);
    } else {
      throw 'Could not launch $googleURL';
    }
  }
}
