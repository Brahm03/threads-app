import 'package:geolocator/geolocator.dart';

mixin MixinListenToloction {
  Stream<void> listenLocation() async* {
    Geolocator.getPositionStream().listen((value) {
      print('Value listening $value');
    });
  }
}

extension FormateDateTimeMixin on DateTime {
  String formatDateTime() {
    // String year = dateTime.year.toString();
    // String month = dateTime.month.toString().padLeft(2, '0');
    // String day = dateTime.day.toString().padLeft(2, '0');
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}

void main(List<String> args) {}

