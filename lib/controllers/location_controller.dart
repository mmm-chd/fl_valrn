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
  try {
    isLoading.value=true;

   LocationPermission permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     permission= await Geolocator.requestPermission();
   }  

   if (permission==LocationPermission.denied || permission== LocationPermission.deniedForever) {
     kecamatan.value = 'Lokasi tidak diizinkan';
      kabupaten.value = '';
      kota.value = '';
      provinsi.value = '';
      return;
   }

   final position= await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
   );
  
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
  
  } catch (e) {
    kecamatan.value = 'Gagal mengambil lokasi';
    kabupaten.value = '';
    kota.value = '';
    provinsi.value = '';
  } finally {
    isLoading.value= false;

  } 
}
}