import 'package:json_annotation/json_annotation.dart';
import 'package:supplier_portal_flutter/models/base_model.dart';

part 'company.g.dart';

@JsonSerializable()
class Company extends BaseModel {
  final String companyCode;
  final String name;
  final bool active;

  Company({
    required this.companyCode,
    required this.name,
    required this.active,
  });
  
  @override
  BaseModel deserializeJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  @override
  Map<String, dynamic> serializeToJson() => _$CompanyToJson(this);
}
