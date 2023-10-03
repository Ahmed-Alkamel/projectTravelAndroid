import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/company.dart';

class CompaniesRepository {
  LaravelApi? _laravelApi;
  CompaniesRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<Company>> all() {
    return _laravelApi!.getAllCompany();
  }

  Future<List<Company>> allTrip() {
    return _laravelApi!.getAllCompanyTrip();
  }
}
