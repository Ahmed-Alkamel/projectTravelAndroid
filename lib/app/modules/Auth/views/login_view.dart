import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Helper/validation.dart';

import '../../../translations/locale.dart';
import '../../widgets/default_widget.dart';
import '../controllers/auth_controller.dart';
import 'auth_view.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.isloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                DefaultCountainer(
                  width: Get.size.width,
                  height: Get.size.height,
                  color: Get.theme.colorScheme.primary,
                ),
                Positioned(
                  top: 100,
                  child: DefaultCountainer(
                    borderRadiusSpecific: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    width: Get.size.width,
                    height: Get.size.height,
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Raha'),
                          Text(
                            LocaleKeys.buttons_login.tr,
                            style: Get.textTheme.titleLarge!.merge(TextStyle(
                                color: Get.theme.colorScheme.primary)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                              key: controller.keyForm,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    DefaultTextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      isborderall: true,
                                      onchange: (p0) {
                                        controller.ident = p0;
                                      },
                                      hintText: LocaleKeys
                                          .authScrean_email_or_phone_hint.tr,
                                      validator: (p0) {
                                        return ValidatorApp.getVaidator(
                                            ValidateType.required, p0);
                                      },
                                      label: LocaleKeys.authScrean_identity.tr,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DefaultTextFormField(
                                      isborderall: true,
                                      hintText:
                                          LocaleKeys.authScrean_pasword_hint.tr,
                                      label: LocaleKeys.authScrean_pasword.tr,
                                      hidpass: controller.showPassword,
                                      validator: (p0) =>
                                          ValidatorApp.getVaidator(
                                              ValidateType.passord, p0),
                                      onchange: (p0) {
                                        controller.password = p0;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    defaultButton(
                                        onPressed: () async {
                                          if (controller.keyForm.currentState!
                                              .validate()) {
                                            await controller.loginUser();
                                          }
                                        },
                                        isResponseve: false,
                                        isIcon: true,
                                        lable: LocaleKeys.buttons_login.tr,
                                        icon: const Icon(
                                          Icons.login,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() => const AuthView());
                                        },
                                        child: Text(
                                          LocaleKeys
                                              .authScrean_aleardyAcount.tr,
                                          style: Get.textTheme.headlineMedium!
                                              .merge(const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Stack(
                                      children: [
                                        Divider(
                                          color: Get.theme.colorScheme.primary,
                                          thickness: 2,
                                        ),
                                        Positioned(
                                          top: -5,
                                          left: Get.width / 2 - 25,
                                          child: Container(
                                            color:
                                                Get.theme.colorScheme.secondary,
                                            child: Text(
                                                LocaleKeys.authScrean_or.tr,
                                                style: Get
                                                    .textTheme.headlineMedium),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        DefaultIcon.svg(
                                          path: 'icons/gmail.svg',
                                          height: 60,
                                          width: 60,
                                        ),
                                        Text(
                                          LocaleKeys
                                              .authScrean_sign_in_google.tr,
                                          style: Get.textTheme.headlineMedium!,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    ));
  }
}
