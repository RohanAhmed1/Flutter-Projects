import 'package:flutter/material.dart';
import 'package:supplier_portal_flutter/home.dart';

import 'login.dart';

class JobLocationsScreen extends StatefulWidget {
  const JobLocationsScreen({super.key});

  @override
  State<JobLocationsScreen> createState() => _JobLocationsScreenState();
}

class _JobLocationsScreenState extends State<JobLocationsScreen> {
  List<int> numbersList = List.generate(100, (index) => index + 1);
  List<int> filteredList = [];

  @override
  void initState() {
    filteredList = numbersList;
    super.initState();
  }

  void filterNumbers(String query) {
    setState(() {
      filteredList = numbersList
          .where((number) => number.toString().contains(query))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          title: const Center(
            child: Text('Job Locations')
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 1:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
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
          ]
        ),
        
        body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterNumbers,
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final number = filteredList[index];
                return ListTile(
                  title: Text("Name: $number"),
                  subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address: $number"),
                Row(
                  children: [
                    IconButton(
                  icon: Icon(Icons.check_box_outlined),
                  tooltip: "Checkin",
                  onPressed: () {
                    // Perform check-in logic
                    debugPrint('Check-In');
                  },
                ),
                    IconButton(
                  icon: Icon(Icons.close),
                  tooltip: "Checkout",
                  onPressed: () {
                    // Perform checkout logic
                    debugPrint('Check-Out');
                  },
                ),
                IconButton(
                  tooltip: "view",
                  icon: Icon(Icons.arrow_right_sharp),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(title: '$number',)),
                    );
                  },
                ),

                  ],
                )
                
              ],
            ),
                );
              },
            ),
          ),]

      ))
      );
  }
}