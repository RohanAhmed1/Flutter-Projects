import 'package:geolocator/geolocator.dart';

class CurrentLocation{
  // method for getting user current location with permission
  static Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

}