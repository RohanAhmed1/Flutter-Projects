import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supplier_portal_flutter/home.dart';
import 'package:supplier_portal_flutter/models/jobLocations.dart';

import 'login.dart';

class JobLocationsScreen extends StatefulWidget {
  const JobLocationsScreen({super.key});

  @override
  State<JobLocationsScreen> createState() => _JobLocationsScreenState();
}

class _JobLocationsScreenState extends State<JobLocationsScreen> {
  List<JobLocations> locationsList = [
    JobLocations(
        name: "Chicago Union Station",
        address: "225 S Canal St, Chicago, IL 60606",
        streetAddress: "streetAddress",
        city: "city",
        zipCode: "zipCode",
        state: "state",
        country: "USA",
        longitude: -87.63538390232054,
        latitude: 41.891374852838894),
    JobLocations(
        name: "Home",
        address: "1200 Keim Trail, Bartlett, IL 60103",
        streetAddress: "streetAddress",
        city: "city",
        zipCode: "zipCode",
        state: "state",
        country: "USA",
        longitude: -88.18783790185631,
        latitude: 41.96285638808078),
    JobLocations(
        name: "Office",
        address: "400 W Lake St, Roselle, IL 60172",
        streetAddress: "streetAddress",
        city: "city",
        zipCode: "zipCode",
        state: "state",
        country: "USA",
        longitude: -88.09161618969705,
        latitude: 41.96132466225174),
    JobLocations(
        name: "Walmart Supercenter",
        address: "314 W Army Trail Rd, Bloomingdale, IL 60108",
        streetAddress: "streetAddress",
        city: "city",
        zipCode: "zipCode",
        state: "state",
        country: "USA",
        longitude: -88.10256334232676,
        latitude: 41.93676549608121),
    JobLocations(
        name: "Walmart Supercenter",
        address: "314 W Army Trail Rd, Bloomingdale, IL 60108",
        streetAddress: "streetAddress",
        city: "city",
        zipCode: "zipCode",
        state: "state",
        country: "USA",
        longitude: -88.10256334232676,
        latitude: 41.93676549608121),
    JobLocations(
        name: "Walmart Supercenter",
        address: "314 W Army Trail Rd, Bloomingdale, IL 60108",
        streetAddress: "streetAddress",
        city: "city",
        zipCode: "zipCode",
        state: "state",
        country: "USA",
        longitude: -88.10256334232676,
        latitude: 41.93676549608121),
  ];
  List<JobLocations> filteredLocationsList = [];

  @override
  void initState() {
    filteredLocationsList = locationsList;
    super.initState();
  }

  void filterLocation(String query) {
    setState(() {
      filteredLocationsList = locationsList
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // debugPrint(filteredLocationsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                title: const Center(child: Text('Job Locations')),
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                          break;

                        default:
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          child: Text("Logout"),
                        ),
                      ];
                    },
                  )
                ]),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: filterLocation,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocationsList.length,
                  itemBuilder: (context, index) {
                    final location = filteredLocationsList[index];
                    // debugPrint("location: $location");
                    return Card(
                        elevation: 2,
                        margin:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          // Name: Location Name
                          title: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                const TextSpan(
                                  text: 'Name:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${location.name}',
                                ),
                              ],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 8),
                              // Address: Location Address
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: 'Address:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    TextSpan(
                                        text: ' ${location.address}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        )),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.where_to_vote_outlined),
                                    tooltip: "Checkin",
                                    onPressed: () {
                                      // Perform check-in logic
                                      debugPrint('Check-In');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.location_off_outlined),
                                    tooltip: "Checkout",
                                    onPressed: () {
                                      // Perform checkout logic
                                      debugPrint('Check-Out');
                                    },
                                  ),
                                  IconButton(
                                    tooltip: "View Map",
                                    icon: const Icon(Icons.map_outlined),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                  title: location.name,
                                                  location: LatLng(
                                                      location.latitude,
                                                      location.longitude),
                                                )),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ])));
  }
}
