import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:threads_app/src/core/utils/location_service.dart';
import 'package:threads_app/src/core/utils/mixin_listen_toLoction.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool isPermitted = false;
  Position? position;

  @override
  void initState() {
    super.initState();
    LocationService.instance.requestPermission().then((v) {
      isPermitted = v;
      setState(() {});
    });
    LocationService.instance.listenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        LocationService.instance.getCurrentLocation().then((value) {
          print('User positoin $value');
          position = value;
          LocationService.instance
              .decodingPosition(
                  lat: position!.latitude, long: position!.longitude)
              .then((v) {
            print('keldi xay ${v}');
          });
        });
      }),
      body: Center(
        child: Text(isPermitted == true
            ? 'Granted ${DateTime(2025, 12, 04).formatDateTime()} ${position ?? "No position"}'
            : "Not allowed"),
      ),
    );
  }
}
