import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/snackbar_service.dart';

Future<Position?> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return null;
  }

  if (permission == LocationPermission.deniedForever) return null;

  SnackbarService.showSnack("Fetching current location");
  return await Geolocator.getCurrentPosition();
}
