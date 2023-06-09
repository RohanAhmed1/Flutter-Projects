import 'package:supplier_portal_flutter/api/api_service.dart';
import 'package:supplier_portal_flutter/services/auth_service.dart';
import 'package:supplier_portal_flutter/services/jwt_service.dart';
import 'package:supplier_portal_flutter/storage/jwt_storage.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  final JwtStorage jwtStorage = JwtStorage();
  final JwtService jwtService = JwtService(jwtStorage: jwtStorage);
  final ApiService apiService = ApiService();
  final AuthService authService = AuthService(apiService: apiService, jwtService: jwtService);
  
  runApp(MyApp(authService: authService));
}


