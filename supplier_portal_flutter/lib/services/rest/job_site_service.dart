
import 'package:supplier_portal_flutter/models/job_site.dart';
import 'package:supplier_portal_flutter/services/rest/base_service.dart';
import 'package:supplier_portal_flutter/constants/app_constants.dart';

class JobSiteService extends BaseService<JobSite> {
  static const String _apiEndPoint = '${AppConstants.SERVER_IP}/jobSite';

  JobSiteService() : super(apiEndPoint: _apiEndPoint);

  @override
  JobSite createModelInstance() {
    return JobSite();
  }
}

// Future<List<JobSite>> jobSiteService = JobSiteService().getAll();
