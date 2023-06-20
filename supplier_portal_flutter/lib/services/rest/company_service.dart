
import 'package:supplier_portal_flutter/models/company.dart';
import 'package:supplier_portal_flutter/services/rest/base_service.dart';

class CompanyService extends BaseService<Company> {
  static const String _apiEndPoint = '/company';

  CompanyService() : super(apiEndPoint: _apiEndPoint);
  
  @override
  Company createModelInstance() {
    return Company();
  }


}

