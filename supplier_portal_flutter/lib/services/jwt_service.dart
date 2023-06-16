import 'package:supplier_portal_flutter/storage/storage.dart';

class JwtService {
  final Storage jwtStorage = Storage(); 
  
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
    return await jwtStorage.getJwtToken();
  }

}