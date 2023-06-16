import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplier_portal_flutter/api/api_service.dart';
import 'package:supplier_portal_flutter/screens/login_screen.dart';
import 'package:supplier_portal_flutter/services/auth_service.dart';
import 'package:supplier_portal_flutter/services/jwt_service.dart';
import 'package:supplier_portal_flutter/storage/company_provider.dart';
import 'package:supplier_portal_flutter/storage/storage.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // this widget is the root(entry point) of the application
  @override
  Widget build(BuildContext context) {
    // Material UI
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Storage>(create: (_) => Storage()),
          ChangeNotifierProvider(create: (_) => CompanyProvider()),
          ProxyProvider<Storage, AuthService>(
            update: (_, jwtStorage, __) => AuthService(
              apiService: ApiService(),
              jwtService: JwtService(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthService>(
            builder: (_, authService, __) {
              return Login(authService: authService);
            },
          ),

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
            )),
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
              useMaterial3: true),

          themeMode: ThemeMode.system,
        ));
  }
}
