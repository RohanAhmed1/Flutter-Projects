import 'package:json_annotation/json_annotation.dart';
import 'package:supplier_portal_flutter/models/base_model.dart';

/*
part 'job_site.g.dart'; // Generated file will have this name

@JsonSerializable()
class JobSite extends BaseModel {
  late String projectCode;
  late String name;
  late String companyCode;
  late String address;
  late String? street;
  late String? city;
  late String? state;
  late String? zipCode;
  late String? country;
  late String? county;
  late double latitude;
  late double longitude;
  late bool active;
  late int radius;

  @override
  late int id;

  /*
  JobSite({
    required this.projectCode,
    required this.name,
    required this.companyCode,
    required this.address,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.county,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.active,
    required this.radius,
  });
  */

  @override
  void deserializeJson(Map<String, dynamic> json) => _$JobSiteFromJson(json);

  @override
  Map<String, dynamic> serializeToJson() => _$JobSiteToJson(this);
    
}
*/
/*
void main() {
  var jobSite = JobSite(
    projectCode: '123',
    name: 'Site A',
    companyCode: 'ABC',
    address: '123 Main St',
    street: 'Main St',
    city: 'City',
    state: 'State',
    zipCode: '12345',
    county: 'County',
    country: 'Country',
    latitude: 37.12345,
    longitude: -122.54321,
    active: true,
    radius: 10,
  );
  const Map<String, dynamic> json = {
    "projectCode": '123',
    "name": 'Site A',
    "companyCode": 'ABC',
    "address": '123 Main St',
    "street": 'Main St',
    "city": 'City',
    "state": 'State',
    "zipCode": '12345',
    "county": 'County',
    "country": 'Country',
    "latitude": 37.12345,
    "longitude": -122.54321,
    "active": true,
    "radius": 10,
  };
  var jobSite = JobSite();


  // Serialize to JSON
  var json2 = jobSite.serializeToJson();
  print(json);

  // Deserialize from JSON
  var newJobSite = JobSite().deserializeJson(json);
  // ... continue printing other properties
}
*/



class JobSite extends BaseModel {
  late String projectCode;
  late String name;
  late String companyCode;
  late String address;
  late String? street;
  late String? city;
  late String? state;
  late String? zipCode;
  late String? county;
  late String? country;
  late double latitude;
  late double longitude;
  late bool active;
  late int radius;

  @override
  late int id;


  @override
  Map<String, dynamic> serializeToJson() {
    return {
      'projectCode': projectCode,
      'name': name,
      'companyCode': companyCode,
      'address': address,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'county': county,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'active': active,
      'radius': radius,
    };
  }


  @override
void deserializeJson(Map<String, dynamic> json) {
  id = json['id'];
  projectCode = json['projectCode'] ?? '';
  name = json['name'] ?? '';
  companyCode = json['companyCode'] ?? '';
  address = json['address'] ?? '';
  street = json['street'] ?? '';
  city = json['city'] ?? '';
  state = json['state'] ?? '';
  zipCode = json['zipCode'] ?? '';
  county = json['county'] ?? '';
  country = json['country'] ?? '';
  latitude = json['latitude'] ?? 0.0;
  longitude = json['longitude'] ?? 0.0;
  active = json['active'] ?? false;
  radius = json['radius'] ?? 0;
}

}

