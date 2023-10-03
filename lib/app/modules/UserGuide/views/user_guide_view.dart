import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../models/basic/main_requiremnt.dart';
import '../../../models/basic/service.dart';
import '../../../models/basic/sub_requiremnt.dart';
import '../../../theme/color.dart';
import '../../home/controllers/home_controller.dart';
import '../../widgets/default_widget.dart';
import '../controllers/user_guide_controller.dart';

class UserGuideView extends GetView<UserGuideController> {
  UserGuideView({Key? key}) : super(key: key);
  final HomeController c = Get.put(HomeController());
  final String titleBottom = 'المتطلبات الرئسية';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBarDesktop(
          title: 'دليل المستخدم',
        ),
        iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // defaultTextFormField(
            //     hintText: 'بحث عن خدمة',
            //     width: MediaQuery.of(context).size.width / 2,
            //     isborderall: true,
            //     suffixIcon: const Icon(
            //       Icons.search,
            //       color: DefaultColor.primaryColor,
            //     )),
            Expanded(
              child: ListView.builder(
                itemCount: c.servicsImportaint!.length,
                itemBuilder: (context, index) {
                  Service item = c.servicsImportaint![index];
                  return GestureDetector(
                    onTap: () {
                      defaultDiloagAnimation(
                          appBar: AppBar(
                            title: const TitleAppBarDesktop(
                              title: 'تفاصيل الخدمة',
                            ),
                            iconTheme: IconThemeData(
                                color: Get.theme.colorScheme.secondary),
                            centerTitle: true,
                          ),
                          body: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              width: Get.width,
                              height: Get.height,
                              child: Column(
                                children: [
                                  Text(
                                    "المتطلبات الرئسية",
                                    style: Get.textTheme.headlineLarge,
                                  ),
                                  SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: item.mainRequirment!
                                          .asMap()
                                          .entries
                                          .map((e) => Text(
                                                (e.key + 1).toString() +
                                                    '- '.toString() +
                                                    e.value.name!,
                                                style: Get
                                                    .textTheme.headlineMedium,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (item.subRequiremnts!.isNotEmpty)
                                    Text(
                                      "المتطلبات الفرعية",
                                      style: Get.textTheme.headlineLarge,
                                    ),
                                  Expanded(
                                      child: SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: item.subRequiremnts!
                                          .asMap()
                                          .entries
                                          .map((datacondataion) => Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (datacondataion.key + 1)
                                                              .toString() +
                                                          '- '.toString() +
                                                          'متطلب'.toString(),
                                                      style: Get.textTheme
                                                          .headlineLarge,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        'الشروط:'.toString(),
                                                        style: Get.textTheme
                                                            .headlineLarge,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      child: Text(
                                                        ' الجنس:'.toString() +
                                                            getGender(
                                                                datacondataion
                                                                    .value
                                                                    .gender!) +
                                                            '\n الحالة الاجتماعية :'
                                                                .toString() +
                                                            getMatrial(datacondataion
                                                                .value
                                                                .idMartial!) +
                                                            '\n العمر :'
                                                                .toString() +
                                                            ' اقل من '
                                                                .toString() +
                                                            datacondataion.value
                                                                .lessThanAge!
                                                                .toString() +
                                                            '\n اكثر من  '
                                                                .toString() +
                                                            datacondataion.value
                                                                .moreThanAge!
                                                                .toString(),
                                                        style: Get.textTheme
                                                            .headlineMedium,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        'تفاصيل المتطلب:'
                                                            .toString(),
                                                        style: Get.textTheme
                                                            .headlineLarge,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children:
                                                                datacondataion
                                                                    .value
                                                                    .detaial!
                                                                    .asMap()
                                                                    .entries
                                                                    .map((e) =>
                                                                        Text(
                                                                          (e.key + 1).toString() +
                                                                              '- '.toString() +
                                                                              e.value.containt!,
                                                                          style: Get
                                                                              .textTheme
                                                                              .headlineMedium,
                                                                        ))
                                                                    .toList(),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          transitionCurve: Curves.bounceInOut,
                          transitionDuration:
                              const Duration(milliseconds: 200));
                    },
                    child: ListTile(
                      leading: SvgPicture.network(
                        item.pathImage!,
                        width: 20,
                        height: 20,
                        color: DefaultColor.primaryColor,
                      ),
                      title: DefaultText(
                        item.name!,
                        style: Get.textTheme.headlineMedium,
                      ),
                      subtitle: item.category != null
                          ? DefaultText(item.name!)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMatrial(int i) {
    var data = c.dataBasic!.martialStatus
        .firstWhere((element) => element.idMartial! == i)
        .nameAr!;
    if (data.isEmpty) {
      return '';
    } else {
      return data;
    }
  }
}

defaultDiloagAnimation(
    {PreferredSizeWidget? appBar,
    Widget? body,
    Curve? transitionCurve,
    Duration? transitionDuration}) async {
  return Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          appBar: appBar,
          body: body,
        ),
      ),
      transitionCurve: transitionCurve ?? Curves.easeInOut,
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 600));
}

class TitleAppBarDesktop extends StatelessWidget {
  const TitleAppBarDesktop({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Get.textTheme.titleLarge,
    );
  }
}

String getGender(int id) {
  if (id == 1) {
    return 'ذكر';
  } else {
    return 'انثي';
  }
}
