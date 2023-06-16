import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supplier_portal_flutter/services/current_location_service.dart';
import 'package:supplier_portal_flutter/services/rest/checkin_checkout_service.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title, required this.location});

  final String title;
  final LatLng location;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _employeeClock = EmployeeClockService();
  final Completer<GoogleMapController> _controller = Completer();
  // we have specified starting camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(41.96132466225174, -88.09161618969705),
    zoom: 14,
  );

  // the list of markers, which will shown in map
  final List<Marker> _markers = <Marker>[];
  /*
  // method for moving screen to user current location
  void moveToCurrentPosition() async {
      final longLat = await CurrentLocation.getUserCurrentLocation();


      // marker added for current user location
      _markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(longLat.latitude, longLat.longitude),
        infoWindow: const InfoWindow(
          title: 'Current Location',
        ),
      ));

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(longLat.latitude, longLat.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    }
  */
  // method for moving screen to user job location
  void moveTojobPosition() async {
    debugPrint("${widget.location.latitude} ${widget.location.longitude}");

    // marker added for current user location
    _markers.add(Marker(
      markerId: const MarkerId("1"),
      position: widget.location,
      infoWindow: const InfoWindow(
        title: 'Job Location',
      ),
    ));

    // specified current users location
    CameraPosition cameraPosition = CameraPosition(
      target: widget.location,
      zoom: 18,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  Timer? _timer;
  int _secondsElapsed = 0;
  bool _timerRunning = false;

  void startTimer() {
    if (!_timerRunning) {
      _timerRunning = true;
      _secondsElapsed = 0;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  String getFormattedTime(int secondsElapsed) {
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
    moveTojobPosition();
  }

  // when drawing starts
  @override
  Widget build(BuildContext context) {
    String timerText = getFormattedTime(_secondsElapsed);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              // title: const Text("Home"),
              title: Text(_timerRunning ? timerText : widget.title),
            ),
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
                /*
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context)
                                    .colorScheme
                                    .inversePrimary), // Change background color
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context)
                                    .colorScheme
                                    .secondary), // Change text color
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context)
                                    .colorScheme
                                    .inversePrimary), // Change background color
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context)
                                    .colorScheme
                                    .secondary), // Change text color
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
                */
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context)
                              .colorScheme
                              .inversePrimary), // Change background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context)
                              .colorScheme
                              .secondary), // Change text color
                    ),
                    onPressed: () {
                      // Perform check-in logic
                      // _employeeClock.checkIn(1, location.id);
                      startTimer();

                      debugPrint('Check-In');
                    },
                    icon: const Icon(Icons.where_to_vote_outlined),
                    label: const Text('Check-In'),
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context)
                                .colorScheme
                                .inversePrimary), // Change background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context)
                                .colorScheme
                                .secondary), // Change text color
                      ),
                      onPressed: () {
                        // Perform check-out logic
                        // _employeeClock.checkOut(1, widget.location.id);
                        stopTimer();
                        debugPrint('Check-Out');
                      },
                      icon: const Icon(
                        (Icons.location_off_outlined),
                      ),
                      label: const Text('Check-Out')),
                ],
              ),
            )));
  }
}
