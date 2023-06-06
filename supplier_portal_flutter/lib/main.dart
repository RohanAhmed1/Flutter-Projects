import 'package:flutter/material.dart';
import 'package:supplier_portal_flutter/jobLocationsScreen.dart';
import 'package:supplier_portal_flutter/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Default light theme settings
        brightness: Brightness.light,
        // primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // Dark theme settings
        // brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      
      themeMode: ThemeMode.system,
      home: const JobLocationsScreen(),
    );
  }
}
