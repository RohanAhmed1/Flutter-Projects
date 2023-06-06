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
  
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _timerRunning = false;

  void startTimer() {
    if (!_timerRunning) {
      _timerRunning = true;
      _secondsElapsed = 0;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
    }
  }

  void stopTimer() {
    if (_timerRunning) {
      _timer?.cancel();
      _timerRunning = false;
    }
  }

  String getTime(int secondsElapsed){
    return '${(_secondsElapsed ~/ 3600).toString().padLeft(2, '0')}:${((_secondsElapsed % 3600) ~/ 60).toString().padLeft(2, '0')}:${(_secondsElapsed % 60).toString().padLeft(2, '0')}';
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
    String timerText = getTime(_secondsElapsed);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          // title: const Text("Home"),
          title: Text(_timerRunning ? timerText : 'Home'),
          
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 1:
                    
                    Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()
                                    ),
                                  );    
                    break;
                    
                  default:
                }
                
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(value: 1,child: Text("Logout"),),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.inversePrimary), // Change background color
                              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary), // Change text color
                            ),
                    onPressed: () {
                      // Perform check-in logic
                      startTimer();
                      
                      debugPrint('Check-In');
                    },
                    child: const Text('Check-In'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.inversePrimary), // Change background color
                              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary), // Change text color
                            ),
                    onPressed: () {
                      // Perform check-out logic
                      stopTimer();
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
