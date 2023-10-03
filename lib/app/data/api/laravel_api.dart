import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as pathApp;
import 'package:path/path.dart' as pa;
import '../../Helper/diohelper.dart';
import '../../models/basic/category.dart';
import '../../models/basic/chat.dart';
import '../../models/basic/company.dart';
import '../../models/basic/customer.dart';
import '../../models/basic/data_basic.dart';
import '../../models/basic/databasicaddServie.dart';
import '../../models/basic/request_services.dart';
import '../../models/basic/service.dart';
import '../../models/basic/state_request.dart';
import '../../models/basic/trips.dart';
import '../../models/basic/user_request.dart';

class LaravelApi extends GetxService {
  Future<LaravelApi> init() async {
    return this;
  }

  Future<List<Service>?> getAllServices() async {
    List? data = await DioHelpper.postData(path: 'ShowServices').then((value) {
      if (value.data['state'] as bool) {
        return value.data['data'];
      } else {
        return null;
      }
    });
    List<Service> tempServices = data!.map((e) => Service.fromMap(e)).toList();

    return tempServices;
  }

  Future<DataBasicOfAddServic?> getDataBasicService() async {
    try {
      var response =
          await DioHelpper.postData(path: 'BaseData/getDataAddService');
      if (response.data['state']) {
        return DataBasicOfAddServicModel.fromMap(response.data).data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Service?> getServicesId(int id) async {
    var respons =
        await DioHelpper.postData(data: {'idService': id}, path: 'ServiceById');
    if (respons.data['state']) {
      return Service.fromMap(respons.data['data']);
    } else {
      return null;
    }
  }

  Future<DataBasic?> getAllDataBasic() async {
    var respons = await DioHelpper.postData(data: null, path: 'BaseData/index');
    if (respons.data['state']) {
      DataBasicModel data = DataBasicModel.fromMap(respons.data);
      return data.data!;
    } else {
      return null;
    }
  }

  Future<List<Category>> getAllCategory() async {
    var respons = await DioHelpper.getData(path: 'category');

    if (respons.data['state']) {
      CategoryModel categoryModel = CategoryModel.fromMap(respons.data);

      return categoryModel.data!;
    } else {
      return [];
    }
  }

  Future<List<Company>> getAllCompany() async {
    Map<String, dynamic>? data =
        await DioHelpper.getData(path: 'Company').then((value) {
      if (value.data['state'] as bool) {
        return value.data;
      } else {
        return null;
      }
    });
    CompanyModel companies = CompanyModel.fromMap(data!);

    return companies.data!;
  }

  Future<List<Company>> getAllCompanyTrip() async {
    try {
      var respons = await DioHelpper.getData(path: 'company/trip');
      if (respons.data['state']) {
        return CompanyModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Trips>> getAllTrips() async {
    Map<String, dynamic>? data =
        await DioHelpper.getData(path: 'trips').then((value) {
      if (value.data['state'] as bool) {
        return value.data;
      } else {
        return null;
      }
    });
    TripsModel trips = TripsModel.fromMap(data!);

    return trips.data!;
  }

  Future<Category> getCategoryById(int id) async {
    try {
      var respons =
          await DioHelpper.postData(data: {'id': id}, path: 'getCategory');
      if (respons.data['state']) {
        return Category.fromMap(respons.data['data']);
      } else {
        return Category();
      }
    } catch (e) {
      return Category();
    }
  }

  Future<List<Service>> getServicedByCategoryId(int id) async {
    try {
      var respons = await DioHelpper.postData(
          data: {'id': id}, path: 'ServiceByCategryid');
      List<Service> services = [];

      var data = ServicesModel.fromMap(respons.data);
      if (data.state) {
        services = data.data ?? [];
        return services;
      } else {
        return services;
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> addRequstServiceTrip(RequestServicesModelSend data) async {
    try {
      var datasend = data.toMap();

      var response =
          await DioHelpper.postData(path: 'BookingTrip/add', data: datasend);

      if (response.data['state'] == true) {
        return true;
      } else {
        print(response.data);
        return false;
      }
    } catch (e) {
      if (e is dio.DioError) {
        print(e.response!.data);
        return false;
      }
      return false;
    }
  }

  Future<bool> addRequstServiceBooking(RequestServicesModelSend data) async {
    try {
      var datasend = data.toMap();

      var response = await DioHelpper.postData(
          path: 'ServicesBooking/Add', data: datasend);
      // print(datasend);
      if (response.data['state'] == true) {
        return true;
      } else {
        print(response.data);
        return false;
      }
    } catch (e) {
      if (e is dio.DioError) {
        print(e.response!.data);
        return false;
      }
      return false;
    }
  }

  Future<bool> notificationRecieve(int id) async {
    try {
      var response = await DioHelpper.postData(
          path: 'notification/recive', data: {'id': id});
      // print(datasend);
      if (response.statusCode == 200) {
        return true;
      } else {
        // print(response.data);
        return false;
      }
    } catch (e) {
      if (e is dio.DioError) {
        // print(e.response!.data);
        return false;
      }
      return false;
    }
  }

  singInUser(User user) async {
    var respons =
        await DioHelpper.postData(path: 'customer/sigin', data: user.toMap());
    if (respons.data['state'] == true) {
      return User.fromMap(respons.data['data']);
    } else if (respons.data['massege'] == "23000") {
      return 23000;
    } else {
      // print(respons.data);
      return -999;
    }
  }

  Future<User?> loginUser(String ident, String password) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'customer/login', data: {'ident': ident, 'password': password});
      if (respons.data['state'] == true) {
        return User.fromMap(respons.data['data']);
      } else {
        print(respons.data);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<UserRequest>?> getRequestUser(int id) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'CustomerRequest/read', data: {'id': id});
      if (respons.statusCode == 200) {
        var model = CutomerRequestModel.fromMap(respons.data);
        return model.data;
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<List<StateRequest>> getStateRequest() async {
    try {
      var respons = await DioHelpper.postData(path: 'BaseData/getStateRequest');
      if (respons.data['state']) {
        return StateRequestModel.fromMap(respons.data).data!;
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<List<Chat>> getAllChat(int idChat) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'chat/read', data: {'idChat': idChat});
      if (respons.data['state']) {
        return ChatModel.fromMap(respons.data).data!;
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<Chat?> sendChatToServer(int idChat, String containt) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'chat/toServer',
          data: {'idChat': idChat, 'containt': containt});
      if (respons.data['state']) {
        return Chat.fromMap(respons.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<bool> verifyMessageServer(int id) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'chat/verifyMessage', data: {'id': id});
      if (respons.data['state']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> refreshUser(int id) async {
    try {
      var respons =
          await DioHelpper.postData(path: 'customer/refresh', data: {'id': id});
      if (respons.data['state']) {
        return User.fromMap(respons.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      Get.log(e.toString());
      return null;
    }
  }

  Future downloadMedia(String path, bool isImage) async {
    try {
      final Directory? pathSave;

      pathSave = await pathApp.getDownloadsDirectory();
      if (isImage) {
        await DioHelpper.download(
            path,
            pathSave!.path +
                '/travelpro/image/'.toString() +
                pa.basename(path));
      } else {
        await DioHelpper.download(path,
            pathSave!.path + '/travelpro/file/'.toString() + pa.basename(path));
      }
    } catch (e) {
      print(e);
    }
  }
}
