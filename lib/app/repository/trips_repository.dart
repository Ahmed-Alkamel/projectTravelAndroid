import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/request_services.dart';
import '../models/basic/trips.dart';

class TripsRepository {
  LaravelApi? _laravelApi;
  TripsRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }

  Future<List<Trips>> all() {
    _laravelApi = Get.find<LaravelApi>();
    return _laravelApi!.getAllTrips();
  }

  Future<bool> addRequstBooking(RequestServicesModelSend data) async {
    return await _laravelApi!.addRequstServiceTrip(data);
  }
}
