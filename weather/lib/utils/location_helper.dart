import 'package:location/location.dart';

class LocationHelper {
  late double latitude=0;
  late double longitude=0;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    //Location için serviş ayakta mı?
    _serviceEnabled =
        await location.serviceEnabled(); // servis ayakta mı onu sordurdu
    if (!_serviceEnabled) {
      // eğer ayakta değilse ayağa kalkması için istek attık
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // hala ayakta değilse yapcak bişe yok boş döndürcez
        return;
      }
    }

    // konum izinlerinin kontrolü
    _permissionGranted =
        await location.hasPermission(); // izin alınmış mı diye sordu
    if (_permissionGranted == PermissionStatus.denied) {
      //eğer reddedildiyse bi daha istek attırdık
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        //eğer hala izin yoksa yapcak bişe yok boş döndürcez
        return;
      }
    }

    // bütün izinler tamam ise location ataması yapılır
    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
  }
}
