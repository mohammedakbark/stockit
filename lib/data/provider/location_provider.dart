import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class LocationService   with ChangeNotifier{
 Location location =  Location();

bool? _serviceEnabled;
PermissionStatus? _permissionGranted;
LocationData? locationData;

  Future  getMyLocation()async{
 

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled!) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled!) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

await location.getLocation().then((value) {
  locationData=value; 
});
}




}