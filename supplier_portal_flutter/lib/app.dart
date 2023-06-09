import 'package:flutter/material.dart';
import 'package:supplier_portal_flutter/screens/login_screen.dart';
import 'package:supplier_portal_flutter/services/auth_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authService});

  final AuthService authService;
  
  // this widget is the root(entry point) of the application
  @override
  Widget build(BuildContext context) {
    // Material UI
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(authService: authService),
      
      // Default light theme settings
      theme: ThemeData(
        // brightness: Brightness.light,
        /*
        primaryColor: const Color.fromARGB(255, 255, 193, 7),
        primaryTextTheme: TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: "Roboto",
            color: const Color.fromARGB(255, 255, 193, 7),
          )
        ),
        hintColor: const Color.fromARGB(0, 0, 0, 0),
        fontFamily: "Roboto",
        typography: Typography(
          black: Typography.blackMountainView,
          white: Typography.whiteMountainView,
          tall: Typography.tall2018,
        ),
        */
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