import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:projecttravel/app/commen/ui.dart';

import '../../../routes/app_pages.dart';
import '../../widgets/default_widget.dart';
import '../controllers/main_screan_controller.dart';

class MainScreanView extends GetView<MainScreanController> {
  const MainScreanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      // appBar: AppBar(
      //   title: const Text('MainScreanView'),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           Get.toNamed(Routes.AUTH);
      //         },
      //         icon: const Icon(Icons.login)),
      //     IconButton(
      //         onPressed: () async {
      //           await Get.find<AuthUserService>().logout();
      //         },
      //         icon: const Icon(Icons.logout))
      //   ],
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => Positioned(
                  bottom: 0,
                  top: controller.currentIndexNavigatorBar.value == 0 ? 80 : 60,
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height - 100,
                      child: MyBottomNavigationBarUpdate(
                        screens: controller.pages,
                        onItemSelected: (int value) {
                          controller.currentIndexNavigatorBar.value = value;
                          controller.updatalogoApp();
                        },
                        items: controller.navBarsItems(),
                        controller: controller.contrllerButtomNavbar,
                      )),
                )),
            Positioned(
              top: 0,
              child: Obx(() => DefaultCountainer(
                    height: controller.currentIndexNavigatorBar.value == 0
                        ? 90
                        : 70,
                    width: Get.width,
                    color: Get.theme.colorScheme.primary,
                    borderRadiusSpecific:
                        controller.currentIndexNavigatorBar.value == 0
                            ? const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))
                            : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // FlatButton
                            IconButton(
                                onPressed: () {
                                  controller.scaffoldKey.currentState!
                                      .openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  color: Get.theme.colorScheme.secondary,
                                )),
                            if (controller.currentIndexNavigatorBar.value != 0)
                              Text(
                                controller.titlePage[
                                    controller.currentIndexNavigatorBar.value],
                                style: Get.textTheme.titleLarge,
                              ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.notifications,
                                        color:
                                            Get.theme.colorScheme.secondary)),
                                IconButton(
                                    onPressed: () async {
                                      await Get.toNamed(Routes.ChatScreen);
                                    },
                                    icon: Icon(Icons.chat,
                                        color: Get.theme.colorScheme.secondary))
                              ],
                            )
                          ]),
                    ),
                  )),
            ),
            GetBuilder<MainScreanController>(
              id: 'logoApp',
              initState: (_) {},
              builder: (_) {
                return controller.currentIndexNavigatorBar.value != 0
                    ? Container()
                    : Positioned(
                        top: 5,
                        right: (Get.width - 90) / 2,
                        child: DefaultIcon.svg(
                          path: 'icons/logo.svg',
                          color: Get.theme.colorScheme.secondary,
                          width: 90,
                          height: 90,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
      drawer: SafeArea(
        child: DefaultCountainer(
          width: Get.width / 3 * 2,
          borderRadiusSpecific: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          child: Column(
            children: [
              DefaultCountainer(
                width: Get.width / 3 * 2,
                color: Get.theme.colorScheme.primary,
                padding: const EdgeInsets.only(
                    top: 45, left: 8, right: 8, bottom: 10),
                child: controller.currentUser == null
                    ? GestureDetector(
                        onTap: () async {
                          await Get.offAllNamed(Routes.AUTH);
                        },
                        child: SizedBox(
                          width: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultIcon.svg(
                                  path: 'icons/login.svg',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "لا تملك حساب",
                                  style:
                                      Get.textTheme.titleLarge!.merge(TextStyle(
                                    color: Get.theme.colorScheme.secondary,
                                  )),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'تسجيل دخول',
                                  style: Get.textTheme.titleMedium!
                                      .merge(TextStyle(
                                    color: Get.theme.colorScheme.secondary,
                                  )),
                                )
                              ]),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            DefaultIcon.svg(
                              path: 'icons/user.svg',
                              width: 50,
                              height: 50,
                              color: Get.theme.colorScheme.secondary,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.currentUser!.nikName!,
                              style: Get.textTheme.titleLarge!.merge(TextStyle(
                                color: Get.theme.colorScheme.secondary,
                              )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.currentUser!.emailAddress!,
                              style: Get.textTheme.titleMedium!.merge(TextStyle(
                                color: Get.theme.colorScheme.secondary,
                              )),
                            )
                          ]),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ItemDrawer(
                      color: Get.theme.colorScheme.primary,
                      path: 'icons/evidence.svg',
                      title: 'الدليل',
                      reqAuth: false,
                      onTap: () {
                        // print('dalil');
                      },
                    ),
                    ItemDrawer(
                      path: 'icons/request.svg',
                      title: 'طلباتي',
                      reqAuth: true,
                      onTap: () {
                        // print('request');
                      },
                    ),
                    ItemDrawer(
                      reqAuth: true,
                      path: 'icons/account.svg',
                      title: 'حسابي',
                      onTap: () {
                        controller.logout();
                      },
                    ),
                    controller.currentUser != null
                        ? ItemDrawer(
                            reqAuth: true,
                            path: 'icons/sign_out.svg',
                            title: 'تسجيل خروج',
                            onTap: () async {
                              await controller.logout();
                            },
                          )
                        : Container(),
                    ItemDrawer(
                      reqAuth: true,
                      path: 'icons/about.svg',
                      title: 'من  نحن',
                      onTap: () {},
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: DefaultIcon.svg(
                              path: 'icons/logo.svg',
                              width: 150,
                              height: 150,
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                          Positioned(
                            top: 240,
                            right: 100,
                            child: Text(
                              'Yemen Travel',
                              style: Get.textTheme.headlineMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              // Flex(direction: Axis.vertical),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDrawer extends GetView<MainScreanController> {
  const ItemDrawer(
      {super.key,
      required this.path,
      required this.title,
      this.color,
      required this.reqAuth,
      this.onTap});
  final String path;
  final String title;
  final bool reqAuth;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: reqAuth
          ? () {
              if (controller.currentUser != null) {
                onTap!();
              } else {}
            }
          : onTap,
      child: DefaultCountainer(
        child: ListTile(
          title: Text(
            title,
            style: Get.textTheme.headlineMedium,
          ),
          leading: DefaultIcon.svg(
            path: path,
            width: 30,
            height: 30,
            color: color,
          ),
        ),
      ),
    );
  }
}


//  GetBuilder<MainScreanController>(
//           id: 'bodyOfMainScreen',
//           builder: (_) {
//             return controller.pages[controller.currentIndexNavigatorBar];
//           },
//         ),
//         bottomNavigationBar: GetBuilder<MainScreanController>(
//           id: 'bottomNavigationBar',
//           builder: (_) {
//             return MyBottomNavigationBar(
//               index: controller.currentIndexNavigatorBar,
//               onTap: (p0) {
//                 controller.changeNavigatorBar(p0);
//               },
//             );
//           },
//         )