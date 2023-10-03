import 'package:dio/dio.dart';
import 'package:get/get.dart' as gt;

import '../services/global_services.dart';

class DioHelpper {
  static late Dio dio;
  static late Dio dioBackgroud;
  static String urlbase =
      'http:///192.168.137.1:5588/projectTravel/public/api/v1/';
  static init() async {
    dio = Dio(BaseOptions(
        baseUrl: gt.Get.find<GlobalService>().baseUrl,
        receiveDataWhenStatusError: true));
  }

  initialbackgroud() {
    dioBackgroud =
        Dio(BaseOptions(baseUrl: urlbase, receiveDataWhenStatusError: true));
  }

  static Future<Response> postData({dynamic data, required String path}) async {
    gt.Get.log(dio.options.baseUrl + path);
    return await dio.post<Map<String, dynamic>>(path, data: data);
  }

  Future<bool> postDataBackgroud({dynamic data, required String path}) async {
    gt.Get.log(urlbase + path);
    var respons =
        await dioBackgroud.post<Map<String, dynamic>>(path, data: data);
    if (respons.data!['state']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Response> getData({required String path}) async {
    gt.Get.log(dio.options.baseUrl + path);
    return await dio.get<Map<String, dynamic>>(
      path,
    );
  }

  static Future<Response> getDataById(
      {required String path,
      required Map<String, dynamic> queryParameters}) async {
    gt.Get.log(dio.options.baseUrl + path);
    return await dio.get<Map<String, dynamic>>(path,
        queryParameters: queryParameters);
  }

  static Future download(String path, String savePath) async {
    Dio dioDowinload = Dio(BaseOptions(receiveDataWhenStatusError: true));
    return await dioDowinload.download(path, savePath);
  }
}
