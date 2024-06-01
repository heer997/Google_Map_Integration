import "dart:async";

import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google Map",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
      ),
      home: const GoogleMapWscubeTech(),
    );
  }
}

class GoogleMapWscubeTech extends StatefulWidget {
  const GoogleMapWscubeTech({super.key});

  @override
  State<GoogleMapWscubeTech> createState() {
    return GoogleMapWscubeTechState();
  }
}

class GoogleMapWscubeTechState extends State<GoogleMapWscubeTech> {
  Completer<GoogleMapController> mController = Completer<GoogleMapController>();
  LatLng? currLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    bool canFetchLocation = await checkBeforeCallingLocation();
    if (canFetchLocation) {
      var currPos = await Geolocator.getCurrentPosition();
      var mapController = await mController.future;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currPos.latitude, currPos.longitude),
            zoom: 12.0,
          ),
        ),
      );
      print("Lat: ${currPos.latitude}, Long: ${currPos.longitude}");
    } else {
      print("Don't have the proper access to fetch the user's location!");
    }
  }

  Future<bool> checkBeforeCallingLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      /// Permission check
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print("Location permissions are not granted!!");
          return false;
        } else if (permission == LocationPermission.deniedForever) {
          print("Location permissions are denied forever!!");
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      print("Location service not enabled!");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Map",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(26.2978, 73.0180),
          zoom: 12.0,
        ),
        onMapCreated: (controller) {
          mController.complete(controller);
        },
      ),
    );
  }
}
