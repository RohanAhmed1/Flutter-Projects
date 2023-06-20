import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supplier_portal_flutter/models/company.dart';
import 'package:supplier_portal_flutter/models/job_site.dart';
import 'package:supplier_portal_flutter/screens/map_screen.dart';
import 'package:supplier_portal_flutter/services/auth_service.dart';
import 'package:supplier_portal_flutter/services/rest/base_service.dart';
import 'package:supplier_portal_flutter/services/rest/checkin_checkout_service.dart';
import 'package:supplier_portal_flutter/services/rest/company_service.dart';
import 'package:supplier_portal_flutter/services/rest/job_site_service.dart';
import 'package:supplier_portal_flutter/storage/company_provider.dart';

import 'login_screen.dart';

class JobLocationsScreen extends StatefulWidget {
  const JobLocationsScreen({super.key, required this.authService});

  final AuthService authService;

  @override
  State<JobLocationsScreen> createState() => _JobLocationsScreenState();
}

class _JobLocationsScreenState extends State<JobLocationsScreen> {
  late BaseService<JobSite> _jobSiteService;
  late BaseService<Company> _companyService;
  final _employeeClock = EmployeeClockService();
  List<JobSite> jobSitesList = [];
  List<JobSite> filteredJobSitesList = [];
  List<Company> companyList = [];
  
  Future<void> requestCompanies() async {
    try {
      // Fetch job sites from the server using the JobSiteService or your API service class
      _companyService = CompanyService();
      List<Company> companies = await _companyService.getAll();

      setState(() {
        companyList = companies;
      });
    } catch (error) {
      // Handle error
      debugPrint('Error fetching job sites: $error');
    }
  }

  Future<void> requestJobSites() async {
    try {
      // Fetch job sites from the server using the JobSiteService or your API service class
      _jobSiteService = JobSiteService();
      List<JobSite> jobSites = await _jobSiteService.getAll();

      setState(() {
        jobSitesList = jobSites.toList();
        filteredJobSitesList = jobSites;
      });
    } catch (error) {
      // Handle error
      debugPrint('Error fetching job sites: $error');
    }
  }

  void logout() {
    widget.authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Login(
                authService: widget.authService,
              )),
    );
  }

  @override
  void initState() {
    super.initState();
    requestJobSites();
  }

  void filterLocation(String query) {
    setState(() {
      filteredJobSitesList = jobSitesList
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // debugPrint(filteredLocationsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanyProvider>(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                title: const Text('Job Locations'),
                actions: [
                  Consumer<CompanyProvider>(
                    builder: (context, provider, _) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: DropdownButton<String>(
                        value: companyProvider.selectedCompanyId,
                        onChanged: (newValue) {
                          CompanyProvider().selectedCompanyId = newValue!;
                          companyProvider.selectedCompanyId = newValue;
                          requestJobSites();
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'DAT',
                            child: Text('DAT'),
                          ),
                          DropdownMenuItem(
                            value: 'USSR',
                            child: Text('USSR'),
                          ),
                          // Add more company options
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        // logout menu item
                        case 1:
                          logout();
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
              // List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredJobSitesList.length,
                  itemBuilder: (context, index) {
                    final location = filteredJobSitesList[index];
                    return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          // Name: <LocationName>
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
                              const SizedBox(height: 8),
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
                                    icon: const Icon(
                                        Icons.where_to_vote_outlined),
                                    tooltip: "Checkin",
                                    onPressed: () async {
                                      debugPrint('Check-In');
                                      debugPrint('${location.id}');
                                      final checkInRes = await _employeeClock
                                          .checkIn(1, location.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(checkInRes)),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon:
                                        const Icon(Icons.location_off_outlined),
                                    tooltip: "Checkout",
                                    onPressed: () async {
                                      debugPrint('Check-Out');
                                      debugPrint('${location.id}');
                                      final checkOutRes = await _employeeClock
                                          .checkOut(1, location.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(checkOutRes)),
                                      );
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
