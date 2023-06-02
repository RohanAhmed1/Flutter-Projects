import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supplier_portal_flutter/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();
  // we have specified starting camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14,
  );

  // the list of markers, which will shown in map
  final List<Marker> _markers = <Marker>[ ];

  // method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR: $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  // method for moving screen to user current location
  void moveToCurrentPosition() async {
          getUserCurrentLocation().then((value) async {
            debugPrint("${value.latitude} ${value.longitude}");

            // marker added for current user location
            _markers.add(Marker(
              markerId: const MarkerId("1"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(
                title: 'Current Location',
              ),
            ));

            // specified current users location
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        }

  // When this page starts loading
  @override
  void initState() {
    super.initState();
    moveToCurrentPosition();
  }

  // when drawing starts
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Home"),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 1:
                    
                    Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login(title: "Login")
                                    ),
                                  );    
                    break;
                    
                  default:
                }
                
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(child: Text("Logout"), value: 1,),
                ];
              },
            )
          ]),
        body: Stack(
        children: [
          SafeArea(
            // on below line creating google maps
            child: GoogleMap(
              // on below line setting camera position
              initialCameraPosition: _kGoogle,
              // on below line we are setting markers on the map
              markers: Set<Marker>.of(_markers),
              // on below line specifying map type.
              mapType: MapType.normal,
              // on below line setting user location enabled.
              myLocationEnabled: true,
              // on below line setting compass enabled.
              compassEnabled: true,
              // on below line specifying controller on map complete.
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent), // Change background color
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Change text color
                            ),
                    onPressed: () {
                      // Perform check-in logic
                      debugPrint('Check-In');
                    },
                    child: const Text('Check-In'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent), // Change background color
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Change text color
                            ),
                    onPressed: () {
                      // Perform check-out logic
                      debugPrint('Check-Out');
                    },
                    child: const Text('Check-Out'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
