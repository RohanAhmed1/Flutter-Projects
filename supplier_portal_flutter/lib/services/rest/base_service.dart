import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supplier_portal_flutter/models/base_model.dart';

class BaseService<Model extends BaseModel> {
  final String apiEndPoint;
  // final BaseModel model = Model();

  BaseService({required this.apiEndPoint});

  Map<String, String> getHeaders() {
    return {'Content-Type': 'application/json'};
  }
  // Model createModelInstance();
  
  // get the model instance data by Id
  Future<BaseModel> get(int id) async {
    final response = await http.get(Uri.parse('$apiEndPoint/$id'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final model = (Model as BaseModel).deserializeJson(jsonData);
      // final model = createModelInstance();
      // model.deserializeJson(jsonData);
      return model;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  // get all data from the model instance
  Future< List<Model> > getAll() async {
    final response = await http.get(Uri.parse(apiEndPoint));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return List<Model>.from(jsonData.map((item) {
        final model = (Model as BaseModel).deserializeJson(jsonData);
        // final model = createModelInstance();
        // model.deserializeJson(item);
        return model;
      }));
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  /*
  // create a data of model instance
  Future<Model> create(Model model) async {
    final response = await http.post(
      Uri.parse('$apiEndPoint/create'),
      headers: this.getHeaders(),
      body: jsonEncode(model.serializeToJson()),
    );
    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final createdModel = createModelInstance();
      createdModel.deserializeJson(jsonData);
      return createdModel;
    } else {
      throw Exception('Failed to create model');
    }
  }
  */
}