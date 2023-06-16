import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supplier_portal_flutter/constants/app_constants.dart';
import 'package:supplier_portal_flutter/models/employee_clock_model.dart';
import 'package:supplier_portal_flutter/services/rest/base_service.dart';
import 'package:supplier_portal_flutter/services/current_location_service.dart';

class EmployeeClockService extends BaseService<EmployeeClock> {
  EmployeeClockService() : super(apiEndPoint: '/employeeClock');

  @override
  EmployeeClock createModelInstance() {
    return EmployeeClock();
  }
  // employee checkIn 
  Future<EmployeeClock> checkIn(int employeeId, int jobSiteId) async {
    final clockInDateTime = DateTime.now().toString();
    final longLat = await CurrentLocation.getUserCurrentLocation();
    final clockInDataJson = {
      "employee": employeeId,
      "jobSite": jobSiteId,
      "clockInDateTime": clockInDateTime,
      "companyCode": BaseService.getDefaultCompany(),
      "clockInLatitude": longLat.latitude,
      "clockInLongitude": longLat.longitude,
    };
    EmployeeClock clockInData = EmployeeClock();
    clockInData.deserializeJson(clockInDataJson);
    final createdClockIn = await create(clockInData);
    return createdClockIn;
  }

  // employee checkOut
  Future<EmployeeClock> checkOut(int employeeId, int jobSiteId) async {
    final clockOutDateTime = DateTime.now().toString();
    final longLat = await CurrentLocation.getUserCurrentLocation();
    // final existingClockIn = await getExistingClockIn(employeeId, jobSiteId);
    final clockOutDataJson = {
      "employee": employeeId,
      "jobSite": jobSiteId,
      "clockOutDateTime": clockOutDateTime,
      "companyCode": BaseService.getDefaultCompany(),
      "clockOutLatitude": longLat.latitude,
      "clockOutLongitude": longLat.longitude,
    };
    EmployeeClock clockOutData = EmployeeClock();
    clockOutData.deserializeJson(clockOutDataJson);
    /*
    if (existingClockIn != null) {
      existingClockIn.clockOutDateTime = clockOutDateTime;
      final updatedClockOut = await update(existingClockIn, existingClockIn.id);
      return updatedClockOut;
    }
    */
    try {

    final updatedClockOut = await update(clockOutData, employeeId);
      return updatedClockOut;
    } catch (err){

    throw Exception('No existing check-in record found.');
    }

  }

  /*
  Future<EmployeeClock?> getExistingClockIn(int employeeId, int jobSiteId) async {
    final response = await http.get(
      Uri.parse('$apiEndPoint/get-existing-clock-in/${BaseService.getDefaultCompany()}/$employeeId/$jobSiteId'),
      headers: BaseService.getDefaultHeader(),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final model = createModelInstance();
      model.deserializeJson(jsonData);
      return model;
    } else {
      throw Exception('Failed to fetch existing clock-in record.');
    }
  }
  */
}
