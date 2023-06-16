import 'package:flutter/material.dart';

class CompanyProvider with ChangeNotifier {
  static CompanyProvider? _instance;
  String _selectedCompanyId = 'DAT';
  
  factory CompanyProvider() {
    _instance ??= CompanyProvider._();
    return _instance!;
  }

  CompanyProvider._();

  String get selectedCompanyId => _selectedCompanyId;

  set selectedCompanyId(String companyId) {
    _selectedCompanyId = companyId;
    notifyListeners();
  }

}

