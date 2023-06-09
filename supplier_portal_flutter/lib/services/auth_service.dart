import 'package:supplier_portal_flutter/api/api_service.dart';
import 'package:supplier_portal_flutter/services/jwt_service.dart';

class AuthService {

  final ApiService apiService;
  final JwtService jwtService;

  AuthService({required this.apiService, required this.jwtService});


  Future<String?> login(String email, String password) async {
    final jwtToken = await apiService.login(email, password);
    if (jwtToken != null) {
      jwtService.storeToken(jwtToken);
      return jwtToken;
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    // Check if the token is stored in secure storage
    final token = await jwtService.getToken();
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    jwtService.deleteToken();
  }
}
