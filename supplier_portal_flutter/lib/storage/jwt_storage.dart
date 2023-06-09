import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtStorage {
  // secured storage for sensitive data
  final storage = const FlutterSecureStorage();
  
  
  // get JWT token from the storage
  Future<String?> getJwtToken() async {
    return await storage.read(key: 'jwt_token');
  }

  // store the JWT token
  Future<void> storeJwtToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  // delete the JWT token from the storage
  Future<void> deleteJwtToken() async {
    await storage.delete(key: 'jwt_token');
  }
}