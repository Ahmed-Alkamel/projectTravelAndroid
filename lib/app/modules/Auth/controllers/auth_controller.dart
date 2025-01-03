import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/customer.dart';
import '../../../repository/auth_repository.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';

class AuthController extends GetxController {
  bool showPassword = true;
  final isloading = false.obs;
  String? ident;
  String? password;

  final keyForm = GlobalKey<FormState>();
  final keyFormSingin = GlobalKey<FormState>();
  final user = User();
  AuthUserRepository? _authUserRepository;
  @override
  void onInit() {
    _authUserRepository = AuthUserRepository();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  singIn(BuildContext context) async {
    isloading.value = true;
    var data = await _authUserRepository!.singInUser(user);
    isloading.value = false;

    if (data is User) {
      // await ShardHelpar.shard.setBool('isLogin', true);
      await Get.find<AuthUserService>().loginUser(data);
      Get.log('user done');
      UiApp.snakSecess('تم', "تم التسجيل بنجاح");
      if (Get.arguments == 1) {
        Get.offNamed(Routes.SERVICES_SCREEN_BENEFITES);
      } else {
        Get.offAllNamed(Routes.MAIN_SCREAN);
      }
    } else {
      if (data == 23000) {
        Get.log('number is find');
        UiApp.snakfaild(
          'fiald ',
          ' number phone is exsest',
        );
      } else {
        Get.log('error ');
        UiApp.snakfaild(
          'fiald ',
          ' requst has error',
        );
      }
    }
  }

  loginUser() async {
    isloading.value = true;
    User? user = await _authUserRepository!.login(ident ?? '', password ?? '');
    isloading.value = false;
    if (user != null) {
      UiApp.snakSecess('تم', "تم التسجيل بنجاح");
      await Get.find<AuthUserService>().loginUser(user);

      if (Get.arguments == 1) {
        Get.offNamed(Routes.SERVICES_SCREEN_BENEFITES);
      } else if (Get.arguments == 2) {
        Get.offNamed(Routes.SERVICES_Public_BENEFITES);
      } else {
        Get.offAllNamed(Routes.MAIN_SCREAN);
      }
    } else {
      UiApp.snakfaild("فشل", 'الرجاء التاكد من اليبانات المدخلة');
    }
  }

  changeShowPass() {
    showPassword = !showPassword;
    update(['password']);
  }
}
