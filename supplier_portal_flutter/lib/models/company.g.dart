// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      companyCode: json['companyCode'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
    )..id = json['id'] as int;

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'companyCode': instance.companyCode,
      'name': instance.name,
      'active': instance.active,
    };
