import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/presentation/modules/user_module/login/reset_forgetpass.dart';

class Controller with ChangeNotifier {
  File? fileImage;
  final storage = FirebaseStorage.instance;
  Future pickeImageFromGallery() async {
    var imagePiker = ImagePicker();

    final pickedXFile = await imagePiker.pickImage(source: ImageSource.gallery);
    if (pickedXFile != null) {
      fileImage = File(pickedXFile.path);
      notifyListeners();
      // return fileImage!;
    }
  }

  Future<String> storeImage(File file, String path) async {
    print("object");
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    final stamp = DateTime.timestamp();
    UploadTask uploadTask =
        storage.ref().child("$path/$stamp").putFile(file, metadata);
    log("object");

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  String radioValue = "Genaral";
  chanegeRadioButtonvalues(value) {
    radioValue = value;
    notifyListeners();
  }

  List<StoreProductModel> choosedList = [];

  Future addToList(StoreProductModel item) async {
    if (choosedList.isEmpty) {
      choosedList.add(item);
    } else {
      if (choosedList.contains(item)) {
        choosedList.remove(item);
      } else {
        choosedList.add(item);
      }
    }

    log(choosedList.length.toString());
    // setState(() {

    // });
    notifyListeners();
  }

  clearList() {
    choosedList.clear();
    // notifyListeners();
  }

  String selectedItem = "Male";

  chanageItem(value) {
    selectedItem = value;
    notifyListeners();
  }

  Position? location;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return location!;
  }
}
