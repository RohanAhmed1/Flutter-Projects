import 'package:supplier_portal_flutter/models/base_model.dart';

class EmployeeClock extends BaseModel {
  late int employee;
  late int jobSite;
  late DateTime? clockInDateTime;
  DateTime? clockOutDateTime;
  double? clockInLatitude;
  double? clockInLongitude;
  double? clockOutLatitude;
  double? clockOutLongitude;
  late String companyCode;
  double? elapsedTime;
  
  @override
  Map<String, dynamic> serializeToJson() {
    return {
      'employee': employee,
      'jobSite': jobSite,
      'clockInDateTime': clockInDateTime?.toIso8601String(),
      'clockOutDateTime': clockOutDateTime?.toIso8601String(),
      'clockInLatitude': clockInLatitude,
      'clockInLongitude': clockInLongitude,
      'clockOutLatitude': clockOutLatitude,
      'clockOutLongitude': clockOutLongitude,
      'companyCode': companyCode,
      'elapsedTime': elapsedTime,
    };
  }

  @override
  void deserializeJson(Map<String, dynamic> json) {
    employee = json['employee'];
    jobSite = json['jobSite'];
    clockInDateTime = json['clockInDateTime'] != null
        ? DateTime.parse(json['clockInDateTime'])
        : null;
    clockOutDateTime = json['clockOutDateTime'] != null
        ? DateTime.parse(json['clockOutDateTime'])
        : null;
    clockInLatitude = json['clockInLatitude'];
    clockInLongitude = json['clockInLongitude'];
    clockOutLatitude = json['clockOutLatitude'];
    clockOutLongitude = json['clockOutLongitude'];
    companyCode = json['companyCode'];
    elapsedTime = json['elapsedTime'];
  }
}
