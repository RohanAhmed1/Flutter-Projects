import 'package:flutter/material.dart';
import 'package:supplier_portal_flutter/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // this widget is the root(entry point) of the application
  @override
  Widget build(BuildContext context) {
    // Material UI
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      
      // Default light theme settings
      theme: ThemeData(
        // brightness: Brightness.light,
        // primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),

      // Dark theme settings
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      
      themeMode: ThemeMode.system,
    );
  }
}
