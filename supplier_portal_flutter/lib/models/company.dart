// import 'package:json_annotation/json_annotation.dart';
import 'package:supplier_portal_flutter/models/base_model.dart';

/*
part 'company.g.dart';

@JsonSerializable()
class Company extends BaseModel {
  late String companyCode;
  late String name;
  late bool active;

  @override
  late int id;


  @override
  void deserializeJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  @override
  Map<String, dynamic> serializeToJson() => _$CompanyToJson(this);
}
*/


class Company extends BaseModel {
  late String companyCode;
  late String name;
  late bool active;

  @override
  late int id;


  @override
  void deserializeJson(Map<String, dynamic> json) {
    companyCode = json['companyCode'] as String;
    name = json['name'] as String;
    active = json['active'] as bool;
  }

  @override
  Map<String, dynamic> serializeToJson() {
    return {
      'companyCode': companyCode,
      'name': name,
      'active': active,
    };
  }
}

