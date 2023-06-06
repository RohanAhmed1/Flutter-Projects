// To parse this JSON data, do
//
//     final JobLocations = JobLocationsFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

List<JobLocations> jobLocationsFromJson(String str) =>
    List<JobLocations>.from(json.decode(str).map((x) => JobLocations.fromJson(x)));

String jobLocationsToJson(List<JobLocations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobLocations {
  JobLocations({
    required this.name,
    required this.address,
    required this.streetAddress,
    required this.city,
    required this.zipCode,
    required this.state,
    required this.country,
    required this.longitude,
    required this.latitude,


  });

  String name;
  String address;
  String streetAddress;
  String city;
  String zipCode;
  String state;
  String country;
  Double longitude;
  Double latitude;

  factory JobLocations.fromJson(Map<String, dynamic> json) => JobLocations(
        name: json["name"],
        address: json["address"],
        streetAddress: json["streetAddress"],
        city: json["city"],
        zipCode: json["zipCode"],
        state: json["state"],
        country: json["country"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "streetAddress": streetAddress,
        "city": city,
        "zipCode": zipCode,
        "state": state,
        "country": country,
        "longitude": longitude,
        "latitude": latitude,
      };
}
