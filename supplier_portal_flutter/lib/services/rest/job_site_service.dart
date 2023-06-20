
import 'package:supplier_portal_flutter/models/job_site.dart';
import 'package:supplier_portal_flutter/services/rest/base_service.dart';

class JobSiteService extends BaseService<JobSite> {
  static const String _apiEndPoint = '/jobSite';

  JobSiteService() : super(apiEndPoint: _apiEndPoint);
  
  @override
  JobSite createModelInstance() {
    return JobSite();
  }


}

// Future<List<JobSite>> jobSiteService = JobSiteService().getAll();
