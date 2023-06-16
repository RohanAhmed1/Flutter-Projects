import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:supplier_portal_flutter/constants/app_constants.dart';
import 'package:supplier_portal_flutter/models/base_model.dart';
import 'package:supplier_portal_flutter/services/jwt_service.dart';
import 'package:supplier_portal_flutter/storage/company_provider.dart';
import 'package:supplier_portal_flutter/storage/storage.dart';

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
        headers: await getDefaultHeader());
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final model = createModelInstance();
      model.deserializeJson(jsonData);
      return model;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // get all data from the API endpoint
  Future<List<Model>> getAll() async {
    final headers = await getDefaultHeader();
    print(headers);
    final response = await http.get(
        Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/getAll/${getDefaultCompany()}'),
        headers: await getDefaultHeader());
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return List<Model>.from(jsonData.map((item) {
        final model = createModelInstance();
        model.deserializeJson(item);
        return model;
      }));
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // create a data of model instance
  Future<Model> create(Model model) async {
    print(getDefaultCompany());
    final response = await http.post(
      Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/create'),
      headers: await getDefaultHeader(),
      body: jsonEncode(model.serializeToJson()),
    );
    print(response.body);
    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final createdModel = createModelInstance();
      createdModel.deserializeJson(jsonData);
      return createdModel;
    } else {
      throw Exception('Failed to create model');
    }
  }

  // update a data of model instance
  Future<Model> update(Model model, int id) async {
    final response = await http.put(
      Uri.parse('${AppConstants.SERVER_IP}$apiEndPoint/update/$id'),
      headers: await getDefaultHeader(),
      body: jsonEncode(model.serializeToJson()),
    );
    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final createdModel = createModelInstance();
      createdModel.deserializeJson(jsonData);
      return createdModel;
    } else {
      throw Exception('Failed to update model');
    }
  }
  // the model instance
  Model createModelInstance();
}
