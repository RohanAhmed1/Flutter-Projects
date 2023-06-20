import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supplier_portal_flutter/constants/app_constants.dart';
import 'package:supplier_portal_flutter/models/base_model.dart';
import 'package:supplier_portal_flutter/services/jwt_service.dart';
import 'package:supplier_portal_flutter/storage/company_provider.dart';

abstract class BaseService<Model extends BaseModel> {
  final String apiEndPoint;

  BaseService({required this.apiEndPoint});

  // get the jwt token
  static Future<String?> getToken() async {
    return await JwtService().getToken();
  }

  // get the default header
  static Future< Map <String, String> > getDefaultHeader() async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await getToken()}'
      };
  }

  // get the default Company
  static String getDefaultCompany() {
    return CompanyProvider().selectedCompanyId;
  }

  // get the data from the API endpoint
  Future<Model> get(int id) async {
    final response = await http.get(
        Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/get/${getDefaultCompany()}/$id'),
        headers: await getDefaultHeader()
      );
    
    print(response.body);
    final jsonRes = jsonDecode(response.body);
    // create a model for record
    final model = createModelInstance();
    model.deserializeJson(jsonRes);
    
    return model;
  }

  // get all data from the API endpoint
  Future<List<Model>> getAll() async {
    final response = await http.get(
        Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/getAll/${getDefaultCompany()}'),
        headers: await getDefaultHeader());

    print(response.body);
    final jsonRes = jsonDecode(response.body);

    return List<Model>.from(jsonRes.map((item) {

      // create a model for each record
      final model = createModelInstance();
      model.deserializeJson(item);

      return model;
    }));
  }

  // create a data of model instance
  Future< Map<String, dynamic> > create(Model model) async {
    final response = await http.post(
      Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/create'),
      headers: await getDefaultHeader(),
      body: jsonEncode(model.serializeToJson()),
    );
    
    print(response.body);
    return jsonDecode(response.body);
    
  }

  // update a data of model instance
  Future< Map<String, dynamic> > update(Model model, int id) async {
    final response = await http.put(
      Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/update/$id'),
      headers: await getDefaultHeader(),
      body: jsonEncode(model.serializeToJson()),
    );
    print(response.body);
    return jsonDecode(response.body);
  }

  // the model instance which is necessary for all the sub classes to implement
  Model createModelInstance();
}
