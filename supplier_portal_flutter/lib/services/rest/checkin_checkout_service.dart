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
  Future<String> checkIn(int employeeId, int jobSiteId) async {
    // prepare the data
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
    // creating a model
    EmployeeClock clockInData = EmployeeClock();
    clockInData.deserializeJson(clockInDataJson);

    final createdClockIn = await create(clockInData);

    // response based on code
    if (createdClockIn['code'] == 201){
     return 'Successfully checkedin'; 
    }
    else if (createdClockIn['code'] == 409){
      return 'This location has already been checked';
    }
    else {
      return 'Unable to perform checkin';
    }
  }
  // employee checkOut
  Future<String> checkOut(int employeeId, int jobSiteId) async {
    // prepare the data
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
    // create a model instance
    EmployeeClock clockOutData = EmployeeClock();
    clockOutData.deserializeJson(clockOutDataJson);

    /*
    if (existingClockIn != null) {
      existingClockIn.clockOutDateTime = clockOutDateTime;
      final updatedClockOut = await update(existingClockIn, existingClockIn.id);
      return updatedClockOut;
    }
    */
    final updatedClockOut = await update(clockOutData, employeeId);
    // response based on code
    if (updatedClockOut['code'] == 201){
     return 'Successfully checkedout'; 
    }
    else if (updatedClockOut['code'] == 400){
      return 'This location has not been checkedIn';
    }
    else {
      return 'Unable to perform checkout';
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
