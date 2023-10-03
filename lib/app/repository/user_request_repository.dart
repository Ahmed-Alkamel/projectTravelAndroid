import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/state_request.dart';
import '../models/basic/user_request.dart';

class UserRequestRepository {
  LaravelApi? _laravelApi;
  UserRequestRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }

  Future<List<UserRequest>?> getRequestById(int id) async {
    return await _laravelApi!.getRequestUser(id);
  }

  Future<List<StateRequest>> getAllStatRequest() async {
    return await _laravelApi!.getStateRequest();
  }
}
