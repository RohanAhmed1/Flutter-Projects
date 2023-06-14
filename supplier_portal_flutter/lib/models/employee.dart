import 'package:supplier_portal_flutter/models/base_model.dart';

class Employee implements BaseModel {
  late int employeeId;
  late String firstName;
  late String lastName;

  @override
  late int id;

  @override
  Map<String, dynamic> serializeToJson() {
    return {
      'employeeId': employeeId,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  BaseModel deserializeJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    return this;
  }
  
}