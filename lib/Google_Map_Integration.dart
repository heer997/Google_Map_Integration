import "package:flutter/material.dart";
import "package:google_map_practical/City/Rajkot_Map.dart";
import "package:google_map_practical/City/Surat_Map.dart";
import "package:google_map_practical/City/Vadodara_Map.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google Map Integration",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
      ),
      home: const GoogleMapIntegration(),
    );
  }
}

class GoogleMapIntegration extends StatefulWidget {
  const GoogleMapIntegration({super.key});

  @override
  State<GoogleMapIntegration> createState() {
    return GoogleMapIntegrationState();
  }
}

class GoogleMapIntegrationState extends State<GoogleMapIntegration> {
  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Map Integration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VadodaraMap();
                          },
                        ),
                      );
                    },
                    child: const Text("Vadodara Map"),
                  ),
                ),
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SuratMap();
                          },
                        ),
                      );
                    },
                    child: const Text("Surat Map"),
                  ),
                ),
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RajkotMap();
                          },
                        ),
                      );
                    },
                    child: const Text("Rajkot Map"),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.0225, 72.5714),
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
    );
  }
}
