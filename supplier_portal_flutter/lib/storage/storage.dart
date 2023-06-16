import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage extends ChangeNotifier {
  static Storage? _instance;
  final storage = const FlutterSecureStorage();

  factory Storage() {
    _instance ??= Storage._();
    return _instance!;
  }

  Storage._();

  Future<String?> getJwtToken() async {
    return await storage.read(key: 'jwt_token');
  }

  Future<void> storeJwtToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
    notifyListeners();
  }

  Future<void> deleteJwtToken() async {
    await storage.delete(key: 'jwt_token');
    notifyListeners();
  }
}
