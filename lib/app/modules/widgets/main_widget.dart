import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/validation.dart';
import '../../data/local/local_data.dart';
import '../../models/basic/customer.dart';
import '../../models/basic/data_basic.dart';
import '../../models/basic/identity_customers.dart';
import '../../theme/color.dart';
import '../../translations/locale.dart';
import '../ServicesScreen/controllers/services_screen_controller.dart';
import '../servicesPublic/controllers/services_public_controller.dart';
import 'default_widget.dart';

Container layoutBodyBoking(
    {ServicesScreenController? controller,
    ServicesPublicController? controllerServi}) {
  return controller != null
      ? Container(
          width: Get.size.width,
          height: Get.size.height,
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => controller.isload.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  // key: controller.keyForm,
                  child: Obx(() => ListView.builder(
                        itemCount: controller.requestBookingServices.length,
                        itemBuilder: (context, index) {
                          if (controller.countAdult.value > index) {
                            return Column(
                              children: [
                                Text("البالغ ${index + 1}"),
                                bodyBookingServices(index,
                                    controller: controller),
                              ],
                            );
                          } else if (controller.countAdult.value +
                                      controller.countChildern.value >
                                  index &&
                              controller.groubeVauleIsFamily.value) {
                            return Column(
                              children: [
                                Text(
                                    'طفل ${(index - controller.countAdult.value) + 1}'),
                                bodyBookingServices(index,
                                    controller: controller),
                              ],
                            );
                          } else {
                            return controller.groubeVauleIsFamily.value
                                ? Column(
                                    children: [
                                      Text(
                                          'الرضيع ${(index - controller.countAdult.value - controller.countChildern.value) + 1}'),
                                      bodyBookingServices(index,
                                          controller: controller),
                                    ],
                                  )
                                : Container();
                          }

                          // if (controller.countAdult.value > index) {
                          //           return formCustomerData(context, controller,
                          //               index: index,
                          //               title: 'بيانات المسافر${index + 1} (بالغ)');
                          //         } else if (controller.countAdult.value +
                          //                 controller.countChildern.value >
                          //             index) {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (طفل اقل من 12 سنة) ");
                          //         } else {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (رضيع اقل من 2 سنة) ");
                          //         }
                        },
                      )))),
        )
      : Container(
          width: Get.size.width,
          height: Get.size.height,
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => controllerServi!.isload.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  // key: controller.keyForm,
                  child: Obx(() => ListView.builder(
                        itemCount:
                            controllerServi.requestBookingServices.length,
                        itemBuilder: (context, index) {
                          if (controllerServi.countAdult.value > index) {
                            return Column(
                              children: [
                                Text("البالغ ${index + 1}"),
                                bodyBookingServices(index,
                                    controllerServi: controllerServi),
                              ],
                            );
                          } else if (controllerServi.countAdult.value +
                                      controllerServi.countChildern.value >
                                  index &&
                              controllerServi.isFamily.value) {
                            return Column(
                              children: [
                                Text(
                                    'طفل ${(index - controllerServi.countAdult.value) + 1}'),
                                bodyBookingServices(index,
                                    controllerServi: controllerServi),
                              ],
                            );
                          } else {
                            return controllerServi.isFamily.value
                                ? Column(
                                    children: [
                                      Text(
                                          'الرضيع ${(index - controllerServi.countAdult.value - controllerServi.countChildern.value) + 1}'),
                                      bodyBookingServices(index,
                                          controllerServi: controllerServi),
                                    ],
                                  )
                                : Container();
                          }

                          // if (controller.countAdult.value > index) {
                          //           return formCustomerData(context, controller,
                          //               index: index,
                          //               title: 'بيانات المسافر${index + 1} (بالغ)');
                          //         } else if (controller.countAdult.value +
                          //                 controller.countChildern.value >
                          //             index) {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (طفل اقل من 12 سنة) ");
                          //         } else {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (رضيع اقل من 2 سنة) ");
                          //         }
                        },
                      )))),
        );
}

Column bodyBookingServices(int index,
    {ServicesScreenController? controller,
    ServicesPublicController? controllerServi}) {
  return controller != null
      ? Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 51, 204, 255),
                        width: 1),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الاول',
                            hintText: 'الاسم الاول',
                            isborderall: true,
                            onchange: (p0) {
                              controller.requestBookingServices[index]
                                  .identityCustomers.name.frisName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الثاني',
                            hintText: 'ادخل الاسم الثاني',
                            isborderall: true,
                            onchange: (p0) {
                              controller.requestBookingServices[index]
                                  .identityCustomers.name.lastName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            label: 'اللقب',
                            hintText: 'ادخل اللقب',
                            isborderall: true,
                            onchange: (p0) {
                              controller.requestBookingServices[index]
                                  .identityCustomers.name.surName = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // DefaultTextFormField(
                    //   label: 'رقم الهاتف',
                    //   hintText: 'ادخل رقم الهاتف لتواصل',
                    //   isborderall: true,
                    //   keyboardType: TextInputType.phone,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'الحالة الاجتماعية',
                        label: const Text('الحالة الاجتماعية'),
                        dataList: controller.dataBasic.value!.martialStatus,
                        onChanged: (p0) {
                          // controller.selectedmartialStatus = p0;
                          controller.requestBookingServices[index]
                              .identityCustomers.martial.value = p0;

                          controller.searchSubrequment(index);
                        },
                        value: controller.requestBookingServices[index]
                            .identityCustomers.martial.value),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'نوع الهوية المطلوبة',
                        label: const Text('نوع الهوية المطلوبة'),
                        dataList: controller.service!.identitfyRequerment!,
                        onChanged: (p0) {
                          controller.requestBookingServices[index]
                              .identityCustomers.typeIdentity = p0;
                          controller.test();
                        },
                        value: null),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => DefaultRadioList(
                          data: controller.dataBasic.value!.gender!,
                          groupValue: controller.requestBookingServices[index]
                              .identityCustomers.gender.value,
                          onChanged: (value) {
                            // controller.selectGender.value = value;
                            controller.requestBookingServices[index]
                                .identityCustomers.gender.value = value;
                            controller.searchSubrequment(index);
                          },
                        )),
                    DefaultDataTimePickerWidget(
                      label: const Text('تاريخ الميلاد'),
                      isborderall: true,
                      onChanged: (p0) {
                        Get.log(p0);
                        controller.requestBookingServices[index]
                            .identityCustomers.datePirth = p0;
                      },
                    )
                  ]),
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('المعلومات الشخصية'),
                    ))
              ],
            ),
            Stack(
              children: [
                MainRequrmentWidgetList(
                  controler: controller,
                  index: index,
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('متطلبات الخدمة'),
                    ))
              ],
            )
          ],
        )
      : Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 51, 204, 255),
                        width: 1),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الاول',
                            hintText: 'الاسم الاول',
                            isborderall: true,
                            onchange: (p0) {
                              controllerServi!.requestBookingServices[index]
                                  .identityCustomers.name.frisName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الثاني',
                            hintText: 'ادخل الاسم الثاني',
                            isborderall: true,
                            onchange: (p0) {
                              controllerServi!.requestBookingServices[index]
                                  .identityCustomers.name.lastName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            label: 'اللقب',
                            hintText: 'ادخل اللقب',
                            isborderall: true,
                            onchange: (p0) {
                              controllerServi!.requestBookingServices[index]
                                  .identityCustomers.name.surName = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // DefaultTextFormField(
                    //   label: 'رقم الهاتف',
                    //   hintText: 'ادخل رقم الهاتف لتواصل',
                    //   isborderall: true,
                    //   keyboardType: TextInputType.phone,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'الحالة الاجتماعية',
                        label: const Text('الحالة الاجتماعية'),
                        dataList:
                            controllerServi!.dataBasic.value!.martialStatus,
                        onChanged: (p0) {
                          // controller.selectedmartialStatus = p0;
                          controllerServi.requestBookingServices[index]
                              .identityCustomers.martial.value = p0;

                          controllerServi.searchSubrequment(index);
                        },
                        value: controllerServi.requestBookingServices[index]
                            .identityCustomers.martial.value),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'نوع الهوية المطلوبة',
                        label: const Text('نوع الهوية المطلوبة'),
                        dataList: controllerServi.service!.identitfyRequerment!,
                        onChanged: (p0) {
                          controllerServi.requestBookingServices[index]
                              .identityCustomers.typeIdentity = p0;
                        },
                        value: null),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => DefaultRadioList(
                          data: controllerServi.dataBasic.value!.gender!,
                          groupValue: controllerServi
                              .requestBookingServices[index]
                              .identityCustomers
                              .gender
                              .value,
                          onChanged: (value) {
                            // controller.selectGender.value = value;
                            controllerServi.requestBookingServices[index]
                                .identityCustomers.gender.value = value;
                            controllerServi.searchSubrequment(index);
                          },
                        )),
                    DefaultDataTimePickerWidget(
                      label: const Text('تاريخ الميلاد'),
                      isborderall: true,
                      onChanged: (p0) {
                        Get.log(p0);
                        controllerServi.requestBookingServices[index]
                            .identityCustomers.datePirth = p0;
                      },
                    )
                  ]),
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('المعلومات الشخصية'),
                    ))
              ],
            ),
            Stack(
              children: [
                MainRequrmentWidgetList(
                  controlerServ: controllerServi,
                  index: index,
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('متطلبات الخدمة'),
                    ))
              ],
            )
          ],
        );
}

class MainRequrmentWidgetList extends StatelessWidget {
  const MainRequrmentWidgetList(
      {super.key, this.controler, this.controlerServ, required this.index});
  final ServicesScreenController? controler;
  final ServicesPublicController? controlerServ;

  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        choosCorrectWidgetMainRequ(index),
        // Column(
        //   children: controlerServ!.service!.mainRequirment!
        //       .map(
        //         (e) => Text(
        //           e.name!,
        //           style: Get.textTheme.headlineSmall,
        //         ),
        //       )
        //       .toList(),
        // ),
        Divider(
          color: Get.theme.colorScheme.primary,
        ),
        Obx(() => choosCorrectWidgetSubRequ(index))
      ],
    );
  }

  Widget choosCorrectWidgetMainRequ(int index) {
    return controler != null
        ? Column(
            children: controler!.service!.mainRequirment!
                .asMap()
                .entries
                .map((e) => e.value.typeFiled!.id == 1
                    ? DefaultTextFormField(
                        keyboardType: TextInputType.text,
                        label: e.value.name,
                        hintText: '',
                        isborderall: true,
                        onchange: (p0) {
                          controler!.saveDataRequst(
                              indexPerson: index,
                              idMain: e.value.id,
                              indexMain: e.key,
                              indexTypFiled: e.value.typeFiled!.id!,
                              value: p0);
                        },
                      )
                    : e.value.typeFiled!.id == 2
                        ? DefaultImagePicker(
                            main: e.value,
                            onTap: () async {
                              await alertChoiseImagePicker();
                              await controler!.saveDataRequst(
                                indexPerson: index,
                                idMain: e.value.id,
                                indexMain: e.key,
                                indexTypFiled: e.value.typeFiled!.id!,
                                value: controler!.image!.path,
                                // fileName: controler.image!.name
                              );

                              // await controler.pickImage();
                            },
                          )
                        : e.value.typeFiled!.id == 3
                            ? DefaultTextFormField(
                                keyboardType: TextInputType.number,
                                label: e.value.name,
                                hintText: '',
                                isborderall: true,
                                onchange: (p0) {
                                  controler!.saveDataRequst(
                                      indexPerson: index,
                                      idMain: e.value.id,
                                      indexMain: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: p0);
                                },
                              )
                            : e.value.typeFiled!.id == 4
                                ? DefaultDataTimePickerWidget(
                                    isborderall: true,
                                    onChanged: (p0) {
                                      controler!.saveDataRequst(
                                          indexPerson: index,
                                          idMain: e.value.id,
                                          indexMain: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 5
                                    ? DefaultFilePicker(
                                        main: e.value,
                                        onTap: () async {
                                          await controler!.filePiicker();
                                          await controler!.saveDataRequst(
                                            indexPerson: index,
                                            idMain: e.value.id,
                                            indexMain: e.key,
                                            indexTypFiled:
                                                e.value.typeFiled!.id!,
                                            value: controler!.fileCurrent!.path,
                                          );
                                        },
                                      )
                                    : e.value.typeFiled!.id == 9
                                        ? Obx(
                                            () => DefaultRadioList(
                                              data: e.value.choose!,
                                              groupValue: controler!
                                                  .requestBookingServices[index]
                                                  .detailsMain![e.key]
                                                  .choice
                                                  .value,
                                              onChanged: (value) {
                                                controler!.saveDataRequst(
                                                    indexPerson: index,
                                                    idMain: e.value.id,
                                                    indexMain: e.key,
                                                    indexTypFiled:
                                                        e.value.typeFiled!.id!,
                                                    value: value);
                                              },
                                            ),
                                          )
                                        : e.value.typeFiled!.id == 8
                                            ? DefaultDropDownForm(
                                                // hintText: 'نوع الهوية المطلوبة',
                                                label: Text(e.value.name!),
                                                dataList: e.value.choose,
                                                onChanged: (p0) {
                                                  controler!.saveDataRequst(
                                                      indexPerson: index,
                                                      idMain: e.value.id,
                                                      indexMain: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: p0);
                                                },
                                                value: controler!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsMain![e.key]
                                                    .choice
                                                    .value)
                                            : Container())
                .toList(),
          )
        : Column(
            children: controlerServ!.service!.mainRequirment!
                .asMap()
                .entries
                .map((e) => e.value.typeFiled!.id == 1
                    ? DefaultTextFormField(
                        keyboardType: TextInputType.text,
                        label: e.value.name,
                        hintText: '',
                        isborderall: true,
                        onchange: (p0) {
                          controlerServ!.saveDataRequst(
                              indexPerson: index,
                              idMain: e.value.id,
                              indexMain: e.key,
                              indexTypFiled: e.value.typeFiled!.id!,
                              value: p0);
                        },
                      )
                    : e.value.typeFiled!.id == 2
                        ? DefaultImagePicker(
                            main: e.value,
                            onTap: () async {
                              await alertChoiseImagePicker();
                              await controlerServ!.saveDataRequst(
                                indexPerson: index,
                                idMain: e.value.id,
                                indexMain: e.key,
                                indexTypFiled: e.value.typeFiled!.id!,
                                value: controlerServ!.image!.path,
                                // fileName: controler.image!.name
                              );

                              // await controler.pickImage();
                            },
                          )
                        : e.value.typeFiled!.id == 3
                            ? DefaultTextFormField(
                                keyboardType: TextInputType.number,
                                label: e.value.name,
                                hintText: '',
                                isborderall: true,
                                onchange: (p0) {
                                  controlerServ!.saveDataRequst(
                                      indexPerson: index,
                                      idMain: e.value.id,
                                      indexMain: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: p0);
                                },
                              )
                            : e.value.typeFiled!.id == 4
                                ? DefaultDataTimePickerWidget(
                                    label: Text(
                                      e.value.name!,
                                      style: Get.textTheme.headlineMedium,
                                    ),
                                    isborderall: true,
                                    onChanged: (p0) {
                                      controlerServ!.saveDataRequst(
                                          indexPerson: index,
                                          idMain: e.value.id,
                                          indexMain: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 5
                                    ? DefaultFilePicker(
                                        main: e.value,
                                        onTap: () async {
                                          await controlerServ!.filePiicker();
                                          await controlerServ!.saveDataRequst(
                                            indexPerson: index,
                                            idMain: e.value.id,
                                            indexMain: e.key,
                                            indexTypFiled:
                                                e.value.typeFiled!.id!,
                                            value: controlerServ!
                                                .fileCurrent!.path,
                                          );
                                        },
                                      )
                                    : e.value.typeFiled!.id == 9
                                        ? Obx(
                                            () => DefaultRadioList(
                                              data: e.value.choose!,
                                              groupValue: controlerServ!
                                                  .requestBookingServices[index]
                                                  .detailsMain![e.key]
                                                  .choice
                                                  .value,
                                              onChanged: (value) {
                                                controlerServ!.saveDataRequst(
                                                    indexPerson: index,
                                                    idMain: e.value.id,
                                                    indexMain: e.key,
                                                    indexTypFiled:
                                                        e.value.typeFiled!.id!,
                                                    value: value);
                                              },
                                            ),
                                          )
                                        : e.value.typeFiled!.id == 8
                                            ? DefaultDropDownForm(
                                                // hintText: 'نوع الهوية المطلوبة',
                                                label: Text(e.value.name!),
                                                dataList: e.value.choose,
                                                onChanged: (p0) {
                                                  controlerServ!.saveDataRequst(
                                                      indexPerson: index,
                                                      idMain: e.value.id,
                                                      indexMain: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: p0);
                                                },
                                                value: controlerServ!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsMain![e.key]
                                                    .choice
                                                    .value)
                                            : Container())
                .toList(),
          );
  }

  Widget choosCorrectWidgetSubRequ(int index) {
    return controler != null
        ? controler!.requestBookingServices[index].subRequiremnt!.value ==
                    null ||
                controler!.requestBookingServices[index].subRequiremnt!.value!
                        .idSubRequerment ==
                    -99
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: controler!.requestBookingServices[index]
                    .subRequiremnt!.value!.detaial!
                    .asMap()
                    .entries
                    .map((e) => e.value.typeFiled!.id == 1
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DefaultTextFormField(
                              keyboardType: TextInputType.text,
                              label: e.value.containt,
                              hintText: '',
                              isborderall: true,
                              onchange: (p0) {
                                controler!.saveDataRequst(
                                    indexPerson: index,
                                    idSub: e.value.id,
                                    indexSub: e.key,
                                    indexTypFiled: e.value.typeFiled!.id!,
                                    value: p0);
                              },
                            ),
                          )
                        : e.value.typeFiled!.id == 2
                            ? DefaultImagePicker(
                                main: e.value,
                                onTap: () async {
                                  await alertChoiseImagePicker();
                                  await controler!.saveDataRequst(
                                      indexPerson: index,
                                      idSub: e.value.id,
                                      indexSub: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: controler!.image!.path);
                                },
                              )
                            : e.value.typeFiled!.id == 3
                                ? DefaultTextFormField(
                                    keyboardType: TextInputType.number,
                                    label: e.value.containt,
                                    hintText: '',
                                    isborderall: true,
                                    onchange: (p0) {
                                      controler!.saveDataRequst(
                                          indexPerson: index,
                                          idSub: e.value.id,
                                          indexSub: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 4
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: DefaultDataTimePickerWidget(
                                          label: Text(e.value.containt ?? ''),
                                          isborderall: true,
                                          onChanged: (p0) {
                                            controler!.saveDataRequst(
                                                indexPerson: index,
                                                idSub: e.value.id,
                                                indexSub: e.key,
                                                indexTypFiled:
                                                    e.value.typeFiled!.id!,
                                                value: p0);
                                          },
                                        ),
                                      )
                                    : e.value.typeFiled!.id == 5
                                        ? DefaultFilePicker(
                                            main: e.value,
                                            onTap: () async {
                                              await controler!.filePiicker();
                                              await controler!.saveDataRequst(
                                                  indexPerson: index,
                                                  idSub: e.value.id,
                                                  indexSub: e.key,
                                                  indexTypFiled:
                                                      e.value.typeFiled!.id!,
                                                  value: controler!
                                                      .fileCurrent!.path);
                                            },
                                          )
                                        : e.value.typeFiled!.id == 9
                                            ? DefaultRadioList(
                                                data: e.value.choose!,
                                                groupValue: controler!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsSub![e.key]
                                                    .choiceSub
                                                    .value,
                                                onChanged: (value) {
                                                  // controler.selectedChoose = value;
                                                  controler!.saveDataRequst(
                                                      indexPerson: index,
                                                      idSub: e.value.id,
                                                      indexSub: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: value);
                                                },
                                              )
                                            : e.value.typeFiled!.id == 8
                                                ? DefaultDropDownForm(
                                                    // hintText: 'نوع الهوية المطلوبة',
                                                    label:
                                                        Text(e.value.containt!),
                                                    dataList: e.value.choose,
                                                    onChanged: (p0) {
                                                      controler!.saveDataRequst(
                                                          indexPerson: index,
                                                          idSub: e.value.id,
                                                          indexSub: e.key,
                                                          indexTypFiled: e.value
                                                              .typeFiled!.id!,
                                                          value: p0);
                                                    },
                                                    value: controler!
                                                        .requestBookingServices[
                                                            index]
                                                        .detailsSub![e.key]
                                                        .choiceSub
                                                        .value,
                                                  )
                                                : const Text(''))
                    .toList(),
              )
        : controlerServ!.requestBookingServices[index].subRequiremnt!.value ==
                    null ||
                controlerServ!.requestBookingServices[index].subRequiremnt!
                        .value!.idSubRequerment ==
                    -99
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: controlerServ!.requestBookingServices[index]
                    .subRequiremnt!.value!.detaial!
                    .asMap()
                    .entries
                    .map((e) => e.value.typeFiled!.id == 1
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DefaultTextFormField(
                              keyboardType: TextInputType.text,
                              label: e.value.containt,
                              hintText: '',
                              isborderall: true,
                              onchange: (p0) {
                                controlerServ!.saveDataRequst(
                                    indexPerson: index,
                                    idSub: e.value.id,
                                    indexSub: e.key,
                                    indexTypFiled: e.value.typeFiled!.id!,
                                    value: p0);
                              },
                            ),
                          )
                        : e.value.typeFiled!.id == 2
                            ? DefaultImagePicker(
                                main: e.value,
                                onTap: () async {
                                  await alertChoiseImagePicker();
                                  await controlerServ!.saveDataRequst(
                                      indexPerson: index,
                                      idSub: e.value.id,
                                      indexSub: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: controlerServ!.image!.path);
                                },
                              )
                            : e.value.typeFiled!.id == 3
                                ? DefaultTextFormField(
                                    keyboardType: TextInputType.number,
                                    label: e.value.containt,
                                    hintText: '',
                                    isborderall: true,
                                    onchange: (p0) {
                                      controlerServ!.saveDataRequst(
                                          indexPerson: index,
                                          idSub: e.value.id,
                                          indexSub: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 4
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: DefaultDataTimePickerWidget(
                                          label: Text(e.value.containt ?? ''),
                                          isborderall: true,
                                          onChanged: (p0) {
                                            controlerServ!.saveDataRequst(
                                                indexPerson: index,
                                                idSub: e.value.id,
                                                indexSub: e.key,
                                                indexTypFiled:
                                                    e.value.typeFiled!.id!,
                                                value: p0);
                                          },
                                        ),
                                      )
                                    : e.value.typeFiled!.id == 5
                                        ? DefaultFilePicker(
                                            main: e.value,
                                            onTap: () async {
                                              await controlerServ!
                                                  .filePiicker();
                                              await controlerServ!
                                                  .saveDataRequst(
                                                      indexPerson: index,
                                                      idSub: e.value.id,
                                                      indexSub: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: controlerServ!
                                                          .fileCurrent!.path);
                                            },
                                          )
                                        : e.value.typeFiled!.id == 9
                                            ? DefaultRadioList(
                                                data: e.value.choose!,
                                                groupValue: controlerServ!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsSub![e.key]
                                                    .choiceSub
                                                    .value,
                                                onChanged: (value) {
                                                  // controler.selectedChoose = value;
                                                  controlerServ!.saveDataRequst(
                                                      indexPerson: index,
                                                      idSub: e.value.id,
                                                      indexSub: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: value);
                                                },
                                              )
                                            : e.value.typeFiled!.id == 8
                                                ? DefaultDropDownForm(
                                                    // hintText: 'نوع الهوية المطلوبة',
                                                    label:
                                                        Text(e.value.containt!),
                                                    dataList: e.value.choose,
                                                    onChanged: (p0) {
                                                      controlerServ!
                                                          .saveDataRequst(
                                                              indexPerson:
                                                                  index,
                                                              idSub: e.value.id,
                                                              indexSub: e.key,
                                                              indexTypFiled: e
                                                                  .value
                                                                  .typeFiled!
                                                                  .id!,
                                                              value: p0);
                                                    },
                                                    value: controlerServ!
                                                        .requestBookingServices[
                                                            index]
                                                        .detailsSub![e.key]
                                                        .choiceSub
                                                        .value,
                                                  )
                                                : const Text(''))
                    .toList(),
              );
  }

  Future alertChoiseImagePicker() => Get.defaultDialog(
        title: 'مكان الصورة',
        titleStyle: Get.textTheme.titleMedium!
            .merge(TextStyle(color: Get.theme.colorScheme.primary)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                if (controler != null) {
                  controler!.pickImage(true);
                } else {
                  controlerServ!.pickImage(true);
                }
              },
              child: Column(
                children: [
                  DefaultIcon(
                    icon: Icons.camera,
                  ),
                  Center(
                    child:
                        Text('الكاميرة', style: Get.textTheme.headlineMedium),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (controler != null) {
                  controler!.pickImage(false);
                } else {
                  controlerServ!.pickImage(false);
                }
              },
              child: Column(
                children: [
                  DefaultIcon(
                    icon: Icons.image,
                  ),
                  Center(
                    child: Text(
                      'المعرض',
                      style: Get.textTheme.headlineMedium,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        confirm: defaultButton(
            isResponseve: false,
            isIcon: false,
            lable: 'الغاء',
            color: Get.theme.colorScheme.primary,
            onPressed: () {
              Get.back();
            }),
      );
}

Future<IdentitBeneficiares?> addIdentitBottomSheet(dynamic controller) async {
  IdentitBeneficiares identity = IdentitBeneficiares(
      identityCustomer: IdentityCustomers(
          gender: Rx<Gender?>(null),
          martial: Rx<MartialStatus?>(null),
          name: Name()));
  final keyform = GlobalKey<FormState>();
  return await Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: true,
      SafeArea(
          child: Container(
              color: Get.theme.colorScheme.secondary,
              height: Get.height - 100,
              child: Form(
                key: keyform,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              identity.isMe = false;
                              Get.back<IdentitBeneficiares?>(result: null);
                            },
                            icon: DefaultIcon(
                              icon: Icons.close,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Get.theme.colorScheme.primary, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: DefaultTextFormField(
                                  margin: const EdgeInsets.only(left: 15),
                                  label: 'الاسم الاول',
                                  hintText: 'الاسم الاول',
                                  validator: (value) {
                                    return ValidatorApp.getVaidator(
                                        ValidateType.required, value);
                                  },
                                  isborderall: true,
                                  onchange: (p0) {
                                    // controller.requestBookingServices[index]
                                    identity.identityCustomer!.name.frisName =
                                        p0;
                                  },
                                ),
                              ),
                              Expanded(
                                child: DefaultTextFormField(
                                  margin: const EdgeInsets.only(left: 15),
                                  label: 'الاسم الثاني',
                                  hintText: 'ادخل الاسم الثاني',
                                  isborderall: true,
                                  validator: (value) {
                                    return ValidatorApp.getVaidator(
                                        ValidateType.required, value);
                                  },
                                  onchange: (p0) {
                                    // controller.requestBookingServices[index]
                                    identity.identityCustomer!.name.lastName =
                                        p0;
                                  },
                                ),
                              ),
                              Expanded(
                                child: DefaultTextFormField(
                                  label: 'اللقب',
                                  hintText: 'ادخل اللقب',
                                  isborderall: true,
                                  validator: (value) {
                                    return ValidatorApp.getVaidator(
                                        ValidateType.required, value);
                                  },
                                  onchange: (p0) {
                                    // controller.requestBookingServices[index]
                                    identity.identityCustomer!.name.surName =
                                        p0;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // DefaultTextFormField(
                          //   label: 'رقم الهاتف',
                          //   hintText: 'ادخل رقم الهاتف لتواصل',
                          //   isborderall: true,
                          //   keyboardType: TextInputType.phone,
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultDropDownForm(
                              validator: (p0) {
                                if (p0 == null) {
                                  return 'لا تترك الحقل فارغ';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'الحالة الاجتماعية',
                              label: const Text('الحالة الاجتماعية'),
                              dataList: controller is ServicesScreenController
                                  ? controller.dataBasic.value!.martialStatus
                                  : controller is ServicesPublicController
                                      ? controller
                                          .dataBasic.value!.martialStatus
                                      : [],
                              onChanged: (p0) {
                                identity.identityCustomer!.martial.value = p0;
                              },
                              value: identity.identityCustomer!.martial.value),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultDropDownForm(
                              validator: (p0) {
                                if (p0 == null) {
                                  return 'لا تترك الحقل فارغ';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'نوع الهوية المطلوبة',
                              label: const Text('نوع الهوية المطلوبة'),
                              dataList: controller is ServicesScreenController
                                  ? controller.service!.identitfyRequerment!
                                  : controller is ServicesPublicController
                                      ? controller.service!.identitfyRequerment!
                                      : [],
                              onChanged: (p0) {
                                identity.identityCustomer!.typeIdentity = p0;
                                // controller.requestBookingServices[index]
                                //     .identityCustomers.typeIdentity = p0;
                                // controller.test();
                              },
                              value: null),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() => DefaultRadioList(
                                data: controller is ServicesScreenController
                                    ? controller.dataBasic.value!.gender!
                                    : controller is ServicesPublicController
                                        ? controller.dataBasic.value!.gender!
                                        : [],
                                groupValue:
                                    identity.identityCustomer!.gender.value,
                                onChanged: (value) {
                                  identity.identityCustomer!.gender.value =
                                      value;
                                },
                              )),

                          DefaultDataTimePickerWidget(
                            validator: (value) {
                              return ValidatorApp.getVaidator(
                                  ValidateType.required, value);
                            },
                            label: const Text('تاريخ الميلاد'),
                            isborderall: true,
                            onChanged: (p0) {
                              Get.log(p0);
                              identity.identityCustomer!.datePirth = p0;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultButton(
                              isResponseve: false,
                              isIcon: false,
                              lable: 'اضافة',
                              onPressed: () {
                                if (keyform.currentState!.validate()) {
                                  identity.isSelected.value = true;
                                  Get.back<IdentitBeneficiares?>(
                                      result: identity);
                                }
                              })
                        ]),
                      ),
                    ],
                  ),
                ),
              ))));
}

class CustomerIdentenyItem extends GetView {
  const CustomerIdentenyItem(
      {super.key,
      required this.identity,
      required this.isShowonly,
      this.onChanged});
  final void Function(bool?)? onChanged;
  final bool isShowonly;
  final IdentitBeneficiares identity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: DefaultIcon.svg(
        path: 'icons/profile.svg',
        width: 40,
        height: 40,
      ),
      title: Text(identity.identityCustomer!.nameid!,
          style: Get.textTheme.headlineMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              LocaleKeys.personalData_gender.tr +
                  DataConst.comme +
                  identity.identityCustomer!.gender.value!.nameAr!,
              style: Get.textTheme.headlineMedium),
          Text(
            'تاريخ الميلاد'.toString() +
                DataConst.comme +
                identity.identityCustomer!.datePirth!,
            style: Get.textTheme.headlineMedium,
          ),
          Text(
              'الحالة الاجتماعية'.toString() +
                  DataConst.comme +
                  identity.identityCustomer!.martial.value!.nameAr!,
              style: Get.textTheme.headlineMedium),
          Text(
              'نوع الهوية'.toString() +
                  DataConst.comme +
                  identity.identityCustomer!.typeIdentity!.name!,
              style: Get.textTheme.headlineMedium),
        ],
      ),
      trailing: !isShowonly
          ? Obx(() => Checkbox(
              value: identity.isSelected.value,
              onChanged: (value) {
                identity.isSelected.value = value!;
                onChanged!(value);

                // controller.currentUser.value!.isSelected = value!;
              }))
          : null,
    );
  }
}
