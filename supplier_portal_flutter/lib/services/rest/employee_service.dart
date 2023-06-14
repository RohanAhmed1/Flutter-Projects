import 'package:supplier_portal_flutter/models/employee.dart';
import 'package:supplier_portal_flutter/services/rest/base_service.dart';

class EmployeeService extends BaseService<Employee> {
  static const String _apiEndPoint = 'https://api.example.com/employees';

  EmployeeService() : super(apiEndPoint: _apiEndPoint);


  @override
  Employee createModelInstance() {
    return Employee();
  }
}

