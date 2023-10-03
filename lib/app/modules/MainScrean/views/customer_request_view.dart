import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../../Helper/function_useable.dart';
import '../../../data/api/laravel_api.dart';
import '../../../data/local/local_data.dart';
import '../../../models/basic/main_requiremnt.dart';
import '../../../models/basic/requst_service_booking.dart';
import '../../../models/basic/type_filed.dart';
import '../../../models/basic/user_request.dart';
import '../../../translations/locale.dart';
import '../../widgets/default_widget.dart';
import '../controllers/main_screan_controller.dart';

class CustomerRequestView extends GetView<MainScreanController> {
  const CustomerRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.stateRequest
                  .map((e) => GestureDetector(
                        onTap: () {
                          controller.shStatRequset(e);
                        },
                        child: Column(
                          children: [
                            IconStateRequsteSelect(
                              id: e.id!,
                              size: 50,
                            ),
                            Text(
                              e.name!,
                              style: Get.textTheme.headlineMedium,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: GetBuilder<MainScreanController>(
              id: 'bodyCustomerRequest',
              // init: MainScreanController(),
              initState: (_) {},
              builder: (_) {
                return controller.requsstData == null ||
                        controller.requsstData!.isEmpty
                    ? Center(
                        child: Text(
                          'لا توجد طلبات',
                          style: Get.textTheme.headlineMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.requsstData != null
                            ? controller.requsstData!.length
                            : 0,
                        itemBuilder: (context, index) {
                          UserRequest userRequest =
                              controller.requsstData![index];
                          return userRequest.requestTrip == null
                              ? ItemServiceRequest(
                                  userRequest: userRequest,
                                )
                              : ItemTripRequest(
                                  userRequest: userRequest,
                                );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class ItemTripRequest extends StatelessWidget {
  ItemTripRequest({super.key, required this.userRequest});
  final UserRequest userRequest;
  var controller = Get.find<MainScreanController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await bottomSheetDetailRequestTrip(userRequest.requestTrip!);
        controller.editeDataInput.clear();
      },
      child: DefaultCountainer(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: IconStateRequsteSelect(
            id: userRequest.state!.id!,
          ),
          title: Center(
              child: Text(
            userRequest.serviceName!,
            style: Get.textTheme.headlineMedium,
          )),
          subtitle: Column(
            children: [
              Text(
                'عدد الاشخاص'.toString() +
                    DataConst.comme +
                    userRequest.requestTrip!.infoBooking!.length.toString(),
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                'وقت الحجز'.toString() +
                    DataConst.comme +
                    getDatetoString(userRequest.requestTrip!.bookingTime)!,
                style: Get.textTheme.headlineSmall,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'حالة الطلب',
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                userRequest.state!.name!,
                style: Get.textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemServiceRequest extends StatelessWidget {
  const ItemServiceRequest({super.key, required this.userRequest});
  final UserRequest userRequest;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bottomSheetDetailRequestServicePublic(
            userRequest.requestServicePublic!);
      },
      child: DefaultCountainer(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: IconStateRequsteSelect(
            id: userRequest.state!.id!,
          ),
          title: Center(
              child: Text(
            userRequest.serviceName!,
            style: Get.textTheme.headlineMedium,
          )),
          subtitle: Column(
            children: [
              Text(
                'عدد الاشخاص'.toString() +
                    DataConst.comme +
                    userRequest.requestServicePublic!.infoBookingService!.length
                        .toString(),
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                'وقن المعاملة'.toString() +
                    DataConst.comme +
                    getDatetoString(userRequest
                        .requestServicePublic!.bookingServicesDate!)!,
                style: Get.textTheme.headlineSmall,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('حالة الطلب', style: Get.textTheme.headlineSmall),
              Text(
                userRequest.state!.name!,
                style: Get.textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future bottomSheetDetailRequestTrip(RequestTrip requestTrip) async {
  return await Get.bottomSheet(DefaultCountainer(
    child: DefaultCountainer(
      padding: const EdgeInsets.all(8.0),
      height: Get.height / 2,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            'تفاصيل الطلب',
            style: Get.textTheme.headlineLarge,
          ),
        ),
        ExpansionTile(
          title: Text('تفاصيل الرحلة', style: Get.textTheme.headlineMedium),
          children: requestTrip.info!
              .map((e) => Column(
                    children: [
                      Text(
                          'اسم الشركة'.toString() +
                              DataConst.comme +
                              e.trip!.company!.name!,
                          style: Get.textTheme.headlineSmall),
                      Text(
                          LocaleKeys.trip_fromCity.tr +
                              DataConst.comme +
                              e.trip!.fromCity!.name! +
                              ' '.toString() +
                              LocaleKeys.trip_ToCity.tr +
                              ' '.toString() +
                              e.trip!.toCity!.name!,
                          style: Get.textTheme.headlineSmall),
                      Text(
                          'خطة الرحلة'.toString() +
                              DataConst.comme +
                              requestTrip.planTrip!.name!,
                          style: Get.textTheme.headlineSmall),
                      Text(
                          'وفت الرحلة'.toString() +
                              DataConst.comme +
                              getDatetoString(e.dateGo)!,
                          style: Get.textTheme.headlineSmall),
                      e.dataBack == null
                          ? Container()
                          : Text(
                              'وقت العودة'.toString() +
                                  DataConst.comme +
                                  getDatetoString(e.dataBack)!,
                              style: Get.textTheme.headlineSmall)
                    ],
                  ))
              .toList(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: requestTrip.infoBooking!.length,
            itemBuilder: (context, index) {
              InfoBooking infoBooking = requestTrip.infoBooking![index];
              return ExpansionTile(
                title: Text(
                    'معلومات المسافر'.toString() +
                        DataConst.comme +
                        infoBooking.person.nameid!,
                    style: Get.textTheme.headlineMedium),
                children: [
                  Text(
                      LocaleKeys.personalData_gender.tr +
                          DataConst.comme +
                          infoBooking.person.getGender!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'الحالة الاجتماعية'.toString() +
                          DataConst.comme +
                          infoBooking.person.getMartiall!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'العمر'.toString() +
                          DataConst.comme +
                          getAge(infoBooking.person.datePirth!).toString(),
                      style: Get.textTheme.headlineSmall),
                  ExpansionTile(
                    title: Text('البينات المدخلة',
                        style: Get.textTheme.headlineMedium),
                    children: infoBooking.dataInputRequrment!.map((e) {
                      DataInputRequrment dataInputRequrment = e;
                      if (dataInputRequrment.idTypeFiled == 1) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 2) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.subReqDetail!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 3) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return Column(
                            children: [
                              ItemDataInputShow(
                                  containt:
                                      dataInputRequrment.mainRequire!.name! +
                                          DataConst.comme +
                                          dataInputRequrment.textValue!,
                                  stateOfRequiremnt:
                                      dataInputRequrment.stateOfRequiremnt!,
                                  dataInputRequrment: dataInputRequrment)
                            ],
                          );
                        }
                      } else if (dataInputRequrment.idTypeFiled == 4) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 5) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.subReqDetail!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 8) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment
                                      .subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.subReqDetail!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseSub ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.mainRequire!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseMain ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 9) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment
                                      .subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.subReqDetail!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseSub ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.mainRequire!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseMain ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else {
                        return Container();
                      }
                    }).toList(),
                  )
                ],
              );
            },
          ),
        )
      ]),
    ),
  ));
}

Future bottomSheetDetailRequestServicePublic(
    RequestServicePublic requestServicePublic) async {
  return await Get.bottomSheet(DefaultCountainer(
    child: DefaultCountainer(
      padding: const EdgeInsets.all(8.0),
      height: Get.height / 2,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            'تفاصيل الطلب',
            style: Get.textTheme.headlineLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: requestServicePublic.infoBookingService!.length,
            itemBuilder: (context, index) {
              InfoBookingService infoBookingService =
                  requestServicePublic.infoBookingService![index];
              return ExpansionTile(
                title: Text(
                    'معلومات المسافر'.toString() +
                        DataConst.comme +
                        infoBookingService.person!.nameid!,
                    style: Get.textTheme.headlineMedium),
                children: [
                  Text(
                      LocaleKeys.personalData_gender.tr +
                          DataConst.comme +
                          infoBookingService.person!.getGender!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'الحالة الاجتماعية'.toString() +
                          DataConst.comme +
                          infoBookingService.person!.getMartiall!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'العمر'.toString() +
                          DataConst.comme +
                          getAge(infoBookingService.person!.datePirth!)
                              .toString(),
                      style: Get.textTheme.headlineSmall),
                  ExpansionTile(
                    title: Text('البينات المدخلة',
                        style: Get.textTheme.headlineMedium),
                    children: infoBookingService.dataInputRequrment!.map((e) {
                      DataInputRequrment dataInputRequrment = e;
                      if (dataInputRequrment.idTypeFiled == 1) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                            containt:
                                dataInputRequrment.subReqDetail!.containt! +
                                    DataConst.comme +
                                    dataInputRequrment.textValue!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        } else {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.mainRequire!.name! +
                                DataConst.comme +
                                dataInputRequrment.textValue!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        }
                      } else if (dataInputRequrment.idTypeFiled == 2) {
                        //image
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.subReqDetail!.name!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        } else {
                          //image
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 3) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.subReqDetail!.name! +
                                DataConst.comme +
                                dataInputRequrment.textValue!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        } else {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.mainRequire!.name! +
                                DataConst.comme +
                                dataInputRequrment.textValue!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        }
                      } else if (dataInputRequrment.idTypeFiled == 4) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.subReqDetail!.name! +
                                DataConst.comme +
                                dataInputRequrment.textValue!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        } else {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.mainRequire!.name! +
                                DataConst.comme +
                                dataInputRequrment.textValue!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        }
                      } else if (dataInputRequrment.idTypeFiled == 5) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.subReqDetail!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        } else {
                          return ItemDataInputShow(
                              containt: dataInputRequrment.mainRequire!.name!,
                              stateOfRequiremnt:
                                  dataInputRequrment.stateOfRequiremnt!,
                              dataInputRequrment: dataInputRequrment);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 8) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                            containt:
                                dataInputRequrment.subReqDetail!.containt! +
                                    DataConst.comme +
                                    dataInputRequrment.subReqDetail!.choose!
                                        .firstWhere((element) =>
                                            element.idChooseSub ==
                                            dataInputRequrment.idChoice)
                                        .containt!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        } else {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.mainRequire!.name! +
                                DataConst.comme +
                                dataInputRequrment.mainRequire!.choose!
                                    .firstWhere((element) =>
                                        element.idChooseMain ==
                                        dataInputRequrment.idChoice)
                                    .containt!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        }
                      } else if (dataInputRequrment.idTypeFiled == 9) {
                        if (dataInputRequrment.mainRequire == null) {
                          return ItemDataInputShow(
                            containt:
                                dataInputRequrment.subReqDetail!.containt! +
                                    DataConst.comme +
                                    dataInputRequrment.subReqDetail!.choose!
                                        .firstWhere((element) =>
                                            element.idChooseSub ==
                                            dataInputRequrment.idChoice)
                                        .containt!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        } else {
                          return ItemDataInputShow(
                            containt: dataInputRequrment.mainRequire!.name! +
                                DataConst.comme +
                                dataInputRequrment.mainRequire!.choose!
                                    .firstWhere((element) =>
                                        element.idChooseMain ==
                                        dataInputRequrment.idChoice)
                                    .containt!,
                            stateOfRequiremnt:
                                dataInputRequrment.stateOfRequiremnt!,
                            dataInputRequrment: dataInputRequrment,
                          );
                        }
                      } else {
                        return Container();
                      }
                    }).toList(),
                  )
                ],
              );
            },
          ),
        )
      ]),
    ),
  ));
}

class SelectIconStateDataInput extends StatelessWidget {
  const SelectIconStateDataInput({
    super.key,
    required this.state,
  });
  final StateRequiremnt state;

  @override
  Widget build(BuildContext context) {
    return state.id == 1
        ? ItemStateRequest(
            icon: Icons.restart_alt_outlined,
            color: Colors.blue,
            title: state.name!,
          )
        : state.id == 3
            ? ItemStateRequest(
                icon: Icons.close,
                color: Colors.red,
                title: state.name!,
              )
            : ItemStateRequest(
                icon: Icons.check,
                color: Colors.green,
                title: state.name!,
              );
  }
}

class ItemStateRequest extends StatelessWidget {
  const ItemStateRequest({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    this.onPressed,
  });
  final IconData icon;
  final String title;
  final Color color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 25,
        ),
        Text(
          title,
          style: Get.textTheme.headlineSmall,
        )
      ],
    );
  }
}

class IconStateRequsteSelect extends StatelessWidget {
  const IconStateRequsteSelect({
    super.key,
    required this.id,
    this.size,
  });

  final int id;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (id == 1) {
      return DefaultIcon.svg(
        path: 'icons/wait.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    } else if (id == 2) {
      return DefaultIcon.svg(
        path: 'icons/progress.svg',
        width: size ?? 30,
        height: size ?? 30,
        color: Get.theme.colorScheme.primary,
      );
    } else if (id == 3) {
      return DefaultIcon.svg(
        path: 'icons/reject.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    } else if (id == 4) {
      return DefaultIcon.svg(
        path: 'icons/complete.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    } else {
      return DefaultIcon.svg(
        path: 'icons/about.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    }
  }
}

class ItemDataInputShow extends StatelessWidget {
  const ItemDataInputShow({
    super.key,
    required this.containt,
    this.path,
    required this.stateOfRequiremnt,
    required this.dataInputRequrment,
  });
  final DataInputRequrment dataInputRequrment;
  final String containt;
  final String? path;
  final StateRequiremnt stateOfRequiremnt;
  @override
  Widget build(BuildContext context) {
    return DefaultCountainer(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: SelectIconStateDataInput(state: stateOfRequiremnt)),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              flex: 2,
              child: Text(containt, style: Get.textTheme.headlineSmall)),
          dataInputRequrment.idTypeFiled == 2
              ? GestureDetector(
                  onTap: () async {
                    await Get.defaultDialog(
                        content: DefaultCountainer(
                      width: Get.width / 2,
                      height: Get.width / 2,
                      child: Image.network(
                        dataInputRequrment.urlFile!,
                        fit: BoxFit.fill,
                      ),
                    ));
                    print('object');
                  },
                  child: const IconWithSpecificLaba(
                    icon: Icons.image,
                    lable: 'عرض',
                  ))
              : dataInputRequrment.idTypeFiled == 5
                  ? GestureDetector(
                      onTap: () async {
                        await Get.find<LaravelApi>()
                            .downloadMedia(dataInputRequrment.urlFile!, false);
                      },
                      child: const IconWithSpecificLaba(
                        icon: Icons.download,
                        lable: 'تنزيل ملف',
                      ))
                  : Container(),
          // stateOfRequiremnt.id != 3
          //     ? Container()
          //     :
          GestureDetector(
            onTap: () async {
              editeDeialogRequrment(dataInputRequrment: dataInputRequrment);
            },
            child: const IconWithSpecificLaba(
              icon: Icons.edit,
              lable: 'تعديل',
            ),
          )
        ],
      ),
    );
  }
}

Future editeDeialogRequrment(
    {required DataInputRequrment dataInputRequrment,
    bool selectFromBottonSave = false,
    bool selectFromBottonBack = false,
    bool isActive = false}) async {
  var controller = Get.find<MainScreanController>();

  int index = controller.addItemEditeAndIndex(dataInputRequrment);

  return await Get.defaultDialog(
    onWillPop: () async {
      bool isDone = controller.checkAdjestExitShowEdite(
        selectFromBottonBack,
        selectFromBottonSave,
        index,
        dataInputRequrment,
      );

      return Future.value(isDone);
    },
    content: SizedBox(
      width: Get.width / 3 * 2,
      height: Get.width / 3 * 2,
      child: Column(
        children: [
          SizedBox(
              child: (dataInputRequrment.idTypeFiled == 8 ||
                      dataInputRequrment.idTypeFiled == 9)
                  ? (dataInputRequrment.mainRequire != null)
                      ? TitleEditeWideget(dataInputRequrment.mainRequire!.name!)
                      : TitleEditeWideget(
                          dataInputRequrment.subReqDetail!.name!)
                  : (dataInputRequrment.idTypeFiled == 2)
                      ? (dataInputRequrment.mainRequire != null)
                          ? /* image */

                          TitleEditeWideget(
                              dataInputRequrment.mainRequire!.name!)
                          : TitleEditeWideget(
                              dataInputRequrment.subReqDetail!.name!)
                      : (dataInputRequrment.idTypeFiled == 5)
                          ? (dataInputRequrment.mainRequire != null)
                              ? TitleEditeWideget(
                                  dataInputRequrment.mainRequire!.name!)
                              : TitleEditeWideget(
                                  dataInputRequrment.subReqDetail!.name!)
                          : (dataInputRequrment.mainRequire != null)
                              ? TitleEditeWideget(
                                  dataInputRequrment.mainRequire!.name!)
                              : TitleEditeWideget(
                                  dataInputRequrment.subReqDetail!.containt!)),
          const Spacer(),
          SizedBox(
              child: DataInputItem(
            dataInputRequrment: dataInputRequrment,
            index: index,
          )),
          const Spacer(),
        ],
      ),
    ),
    cancel: defaultButton(
        color: Colors.redAccent,
        isResponseve: true,
        isIcon: false,
        lable: 'عودة',
        onPressed: () {
          selectFromBottonBack = true;
          Get.back();
        }),
    confirm: defaultButton(
        isResponseve: true,
        isIcon: false,
        lable: ' عودة وحفظ التغيرات موقتا ',
        onPressed: () {
          selectFromBottonSave = true;

          Get.back();
        }),
  );
}

// ignore: must_be_immutable
class DataInputItem extends StatelessWidget {
  DataInputItem(
      {super.key, required this.dataInputRequrment, required this.index});
  final DataInputRequrment dataInputRequrment;
  final int index;
  var controller = Get.find<MainScreanController>();
  @override
  Widget build(BuildContext context) {
    if (dataInputRequrment.idTypeFiled == 1) {
      return DefaultTextFormField(
        isborderall: true,
        onchange: (p0) {
          controller.editeDataInput[index].textValue = p0;
        },
      );
    } else if (dataInputRequrment.idTypeFiled == 2) {
      return IconButton(
          onPressed: () async {
            await controller.alertChoiseImagePicker();
            controller.editeDataInput[index].urlFile = base64Encode(
                (await File(controller.image!.path).readAsBytes()));
            controller.editeDataInput[index].fileName =
                path.basename(controller.image?.path ?? 'errorimage');
          },
          icon: const Icon(Icons.image));
    } else if (dataInputRequrment.idTypeFiled == 3) {
      /*number */
      return DefaultTextFormField(
        keyboardType: TextInputType.number,
        isborderall: true,
        onchange: (p0) {
          controller.editeDataInput[index].textValue = p0;
        },
      );
    } else if (dataInputRequrment.idTypeFiled == 4) {
      /* dateTime */
      return DefaultDataTimePickerWidget(
        // label: const Text('تاريخ الميلاد'),
        isborderall: true,
        onChanged: (p0) {
          controller.editeDataInput[index].textValue = p0;
        },
      );
    } else if (dataInputRequrment.idTypeFiled == 5) {
      /* file */
      return DefaultFilePicker(main: dataInputRequrment, onTap: () {});
    } else if (dataInputRequrment.idTypeFiled == 8 ||
        dataInputRequrment.idTypeFiled == 9) {
      if (dataInputRequrment.mainRequire != null) {
        return DefaultDropDownForm(
            dataList: dataInputRequrment.mainRequire!.choose,
            onChanged: (value) {
              Choose choose = value as Choose;
              controller.editeDataInput[index].idChoice = choose.idChooseMain;
            },
            value: dataInputRequrment.mainRequire!.choose!.singleWhere(
                (element) =>
                    element.idChooseMain == dataInputRequrment.idChoice));
      } else {
        return DefaultDropDownForm(
            dataList: dataInputRequrment.subReqDetail!.choose,
            onChanged: (value) {
              Choose choose = value as Choose;
              controller.editeDataInput[index].idChoice = choose.idChooseMain;
            },
            value: dataInputRequrment.subReqDetail!.choose!.first);
      }
    } else {
      return Container();
    }
  }
}

class TitleEditeWideget extends StatelessWidget {
  const TitleEditeWideget(
    this.title, {
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Get.textTheme.headlineSmall,
    );
  }
}

class IconWithSpecificLaba extends StatelessWidget {
  const IconWithSpecificLaba({
    super.key,
    required this.icon,
    required this.lable,
  });
  final IconData icon;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          Text(
            lable,
            style: Get.textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
