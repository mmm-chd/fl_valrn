import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController{
  final kecamatan = ''.obs;
  final kabupaten = ''.obs;
  final provinsi = ''.obs;
  final kota = ''.obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    detectLocation();
  }

Future<void> detectLocation() async {
  // ambil position
  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // reverse geocoding
  final placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  if (placemarks.isNotEmpty) {
      final place = placemarks.first;

      kecamatan.value = place.subLocality ?? '';
      kabupaten.value =
          place.subAdministrativeArea ?? place.locality ?? '';
      kota.value = place.locality ?? '';
      provinsi.value = place.administrativeArea ?? '';
    }

    isLoading.value = false;
  }
}
