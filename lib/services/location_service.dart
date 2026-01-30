import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService{
  static Future<String?> getAddress() async{
    LocationPermission permission= await Geolocator.checkPermission();
    if (permission==LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemarks= await placemarkFromCoordinates(position.latitude, position.longitude);

    final place= placemarks.first;

    return "${place.locality}, ${place.administrativeArea}";
  }
}