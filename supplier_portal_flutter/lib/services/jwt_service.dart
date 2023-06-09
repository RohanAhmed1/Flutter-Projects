import 'package:supplier_portal_flutter/storage/jwt_storage.dart';

class JwtService {
  final JwtStorage jwtStorage;

  JwtService({required this.jwtStorage});

  // store the jwt token
  Future<void> storeToken(String token) async {
    return jwtStorage.storeJwtToken(token);
  }

  // delete the jwt token
  Future<void> deleteToken() async {
    return jwtStorage.deleteJwtToken();
  }

  // get the jwt token
  Future<String?> getToken() async {
    return jwtStorage.getJwtToken();
  }
}