import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supplier_portal_flutter/constants/app_constants.dart';


class ApiService {
  static const String loginEndpoint = '/user/login';

  // api call for login
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('${AppConstants.SERVER_IP}$loginEndpoint');
    final response = await http
        .post(url, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      print(token);
      return token;
    } else {
      return null;
    }
  }
  
  // Add more end points (future use)
}
