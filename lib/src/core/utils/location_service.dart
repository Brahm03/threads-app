import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:threads_app/src/core/utils/mixin_listen_toLoction.dart';
// * 45.2432432 -> Tashkent Uzbekistan
// * mixin -> 

class LocationService with MixinListenToloction {
  static LocationService instance = LocationService._internal();
  LocationService._internal();

  Future<Position> getCurrentLocation() async {
    LocationSettings locationSettings =
        LocationSettings(accuracy: LocationAccuracy.bestForNavigation);
    final position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    return position;
  }

  Future<bool> requestPermission() async {
    bool isLocationServiceEnabled = false;
    late LocationPermission locationPermission;

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == false) {
      return false;
    }

    locationPermission = await Geolocator.requestPermission();

    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return false;
      } else if (locationPermission == LocationPermission.denied) {
        return false;
      }

      return true;
    }
    return true;
  }

  Future<String> decodingPosition(
      {required double lat, required double long}) async {
    try {
      print('decoding posotion $lat $long');
      final placemark = await placemarkFromCoordinates(lat, long).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          print('yetib keldik ishlamadi AbduGPT');
          return Future.error('yetib keldik ishlamadi AbduGPT');
        },
      );
      print(
          "${placemark} ${placemark.first.street} . ${placemark.first.country}");
      print('after decoding posotion');
      return "${placemark.first.administrativeArea},${placemark.first.country}";
    } catch (e) {
      print('plugin $e');
      return 'no location';
    }
  }
}

// * --> Dart OOP variables operators(if else) loops(cycle for while do while) -> for
// * --> UI/UX dribble figma container, row
// * --> package/plugin file_picker | image_picker
// * --> audio_player -> wakelock
// * --> video player -> chewie_player
// * --> state managment -> cubit/provider statefull
// * --> SOLID princples -> S-> Single Responsibility
// * --> DRY -> Dont repeat yourself -> copy/paste
// * --> KISS -> keep it simple stupid -> bitta code sodda saqla
// ! --> File 10000 
// * --> REST API --> integration (internet base dan ob kelish)
// * API -> Application programming interface 
// * APi -> 4 methods | 1. get, 2. post, 3. delete. 4. patch, 5. put
// * Map -> Google map -> lat long -> map objects
// * Cacheing -> GetStorage -> device small value(int, string , double etc) 
// * Cacheing -> Hive_ce -> device big value(model
// * Firestore -> collection -> document 




// * chewie_player