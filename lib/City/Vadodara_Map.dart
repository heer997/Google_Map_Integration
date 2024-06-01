import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vadodara Map Location",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
      ),
      home: VadodaraMap(),
    );
  }
}

class VadodaraMap extends StatelessWidget {
  VadodaraMap({super.key});

  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vadodara Map Location",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(22.3072, 73.1812),
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
    );
  }
}
