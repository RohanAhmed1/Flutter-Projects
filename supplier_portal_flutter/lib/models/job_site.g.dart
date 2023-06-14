// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSite _$JobSiteFromJson(Map<String, dynamic> json) => JobSite()
  ..projectCode = json['projectCode'] as String
  ..name = json['name'] as String
  ..companyCode = json['companyCode'] as String
  ..address = json['address'] as String
  ..street = json['street'] as String
  ..city = json['city'] as String
  ..state = json['state'] as String
  ..zipCode = json['zipCode'] as String
  ..county = json['county'] as String
  ..country = json['country'] as String
  ..latitude = (json['latitude'] as num).toDouble()
  ..longitude = (json['longitude'] as num).toDouble()
  ..active = json['active'] as bool
  ..radius = json['radius'] as int
  ..id = json['id'] as int;

Map<String, dynamic> _$JobSiteToJson(JobSite instance) => <String, dynamic>{
      'projectCode': instance.projectCode,
      'name': instance.name,
      'companyCode': instance.companyCode,
      'address': instance.address,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'county': instance.county,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'active': instance.active,
      'radius': instance.radius,
      'id': instance.id,
    };
