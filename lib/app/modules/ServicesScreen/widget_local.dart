// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'dart:math' as math;
import '../../data/local/local_data.dart';

import '../../models/basic/trips.dart';
import '../../theme/color.dart';
import '../../translations/locale.dart';
import '../widgets/default_widget.dart';
import 'controllers/services_screen_controller.dart';


class TripCard extends GetView<ServicesScreenController> {
  const TripCard({super.key, required this.trip, this.onlyShow = false});

  final Trips trip;
  final bool? onlyShow;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!onlyShow!) {
          await controller.endBootmSheetBookingTrip(trip);
          // bootomSheetBookingTrip(trip, controller);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Neumorphic(
            style: NeumorphicStyle(color: Get.theme.colorScheme.secondary),
            child: Stack(children: [
              Positioned(
                top: 0,
                child: ClipPath(
                  clipper: WaveClipperOne(flip: true),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ),
              Positioned(
                  top: 60,
                  left: 10,
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.trip_price.tr),
                        Text(trip.price!.toString()),
                        const Divider(),
                      ],
                    ),
                  )),
              Positioned(
                  top: 10,
                  right: 5,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Neumorphic(
                      padding: const EdgeInsets.all(5),
                      style: const NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Center(
                        child: NeumorphicText(
                          trip.company!.name!,
                          textStyle: NeumorphicTextStyle(fontSize: 12),
                          curve: Curves.linear,
                          style: const NeumorphicStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 10,
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Column(
                        children: [
                          trip.category!.idCategoryMain == 9 ||
                                  trip.category!.idCategoryMain == 12
                              ? DefaultIcon.svg(
                                  path: 'icons/plane1.svg',
                                  width: 30,
                                  height: 30,
                                  color: Get.theme.colorScheme.secondary,
                                )
                              : trip.category!.idCategoryMain == 10 ||
                                      trip.category!.idCategoryMain == 7
                                  ? DefaultIcon.svg(
                                      path: 'icons/bus.svg',
                                      width: 30,
                                      height: 30,
                                      color: Get.theme.colorScheme.secondary,
                                    )
                                  : DefaultIcon.svg(
                                      path: 'icons/boat.svg',
                                      width: 30,
                                      height: 30,
                                      color: Get.theme.colorScheme.secondary,
                                    ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.category.value!.subCategory!
                                  .firstWhere((element) =>
                                      element.idCategoryMain ==
                                      trip.category!.idSubCategory)
                                  .nameCategoryMain!),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text('&'),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(trip.category!.nameCategoryMain!)
                            ],
                          )
                        ],
                      )))),
              Positioned(
                  top: 80,
                  child: SizedBox(
                    height: 125,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      Expanded(
                        child: dataGoolandTime(),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Expanded(child: dataLeft()),
                    ]),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  Widget dataGoolandTime() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trip.fromCity!.name!),
              ClipPath(
                clipper: ArrowClipper(12, 9, Edge.LEFT),
                child: Container(
                    color: Get.theme.colorScheme.primary,
                    width: 100,
                    height: 20),
              ),
              Text(trip.toCity!.name!)
            ],
          ),
        ),
        const Divider(),
        Text(LocaleKeys.trip_dateAndTimeSeats.tr),
        Text(
            '${trip.dateGo!.day} - ${trip.dateGo!.month} - ${trip.dateGo!.year}'),
        const Divider(),
      ]),
    );
  }

  Widget dataLeft() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: const [
            Text('عدد المقاعد المتاحة'),
            SizedBox(
              height: 1,
            ),
            Text('0'),
          ],
        ),
        const Divider(),
        Text(LocaleKeys.trip_dateAndTimeSeats.tr),
        const Text('0'),
        const Divider(),
      ]),
    );
  }
}

// ignore: must_be_immutable
class DefaultDropDownServices extends StatelessWidget {
  DefaultDropDownServices(
      {super.key,
      this.title,
      this.onSaved,
      required this.dataList,
      this.helpText,
      required this.onChanged,
      required this.value,
      this.colorTextShow = DefaultColor.textPrimary,
      this.height = 40,
      this.enableBorderColor = DefaultColor.primaryColor,
      this.focuseBorderColor = DefaultColor.sencondreColor,
      this.width = 100});
  String? title;
  Function(dynamic)? onSaved;
  List<dynamic>? dataList;
  String? helpText;
  Function(dynamic) onChanged;
  dynamic value;
  Color colorTextShow;
  double height = 40;
  Color enableBorderColor;
  Color focuseBorderColor;
  double width = 100;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (title == null)
              ? Container()
              : DefaultText(
                  title!,
                ),
          Center(
            child: DropdownButtonFormField<dynamic>(
                onSaved: onSaved,
                alignment: Alignment.topCenter,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  height: 1,
                ),
                decoration: InputDecoration(
                    helperText: helpText,
                    contentPadding: const EdgeInsets.all(8.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 1, color: enableBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 1, color: focuseBorderColor))),
                value: value,
                items: dataList!
                    .map((e) => DropdownMenuItem<dynamic>(
                          value: e,
                          child: DefaultText(
                            e.value.nameArabic,
                          ),
                        ))
                    .toList(),
                onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

Future bootomSheetBookingTrip(Trips trip, ServicesScreenController controller) {
  return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TripCard(
                trip: trip,
                onlyShow: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Text('نوع الحجز'),
                  Obx(() => itemIsFamilyWidget(controller))
                ],
              ),
              Obx(() => Column(children: [
                    Row(
                      children: [
                        Expanded(child: DefaultText('البالغين')),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        controller.incrementCountTravels(id: 1);
                                      },
                                      icon: const Icon(Icons.add))),
                              Expanded(
                                child: Obx(() => Center(
                                    child: DefaultText(controller
                                        .countAdult.value
                                        .toString()))),
                              ),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        controller.decrementCountTravels(id: 1);
                                      },
                                      icon: const Icon(Icons.remove))),
                            ],
                          ),
                        )
                      ],
                    ),
                    controller.groubeVauleIsFamily.value
                        ? Row(
                            children: [
                              Expanded(child: DefaultText('الأطفال اقل 12')),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.incrementCountTravels(
                                                  id: 2);
                                            },
                                            icon: const Icon(Icons.add))),
                                    Expanded(
                                      child: Obx(() => Center(
                                            child: DefaultText(controller
                                                .countChildern.value
                                                .toString()),
                                          )),
                                    ),
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.decrementCountTravels(
                                                  id: 2);
                                            },
                                            icon: const Icon(Icons.remove))),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    controller.groubeVauleIsFamily.value
                        ? Row(
                            children: [
                              Expanded(
                                  child: DefaultText('الرضع اقل من سنتين')),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.incrementCountTravels(
                                                  id: 3);
                                            },
                                            icon: const Icon(Icons.add))),
                                    Expanded(
                                      child: Obx(() => Center(
                                            child: DefaultText(controller
                                                .countbaby.value
                                                .toString()),
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          controller.decrementCountTravels(
                                              id: 3);
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container()
                  ])),
              Center(
                  child: GFButton(
                      text: 'done',
                      onPressed: () async {
                        Get.back();

                        controller.endBootmSheetBookingTrip(trip);
                      }))
            ],
          ),
        ),
      ),
      backgroundColor: Get.theme.colorScheme.secondary);
}

// Example 7
class DefaulteTabBr extends StatelessWidget {
  const DefaulteTabBr({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ContainedTabBarViewState> key = GlobalKey();
    ContainedTabBarView containedTabBarView = ContainedTabBarView(
      key: key,
      tabs: const [
        Text('First'),
        Text('Second'),
      ],
      views: [
        Container(color: Colors.red),
        Container(color: Colors.green),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example 7'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => key.currentState?.previous(),
            child: const Icon(Icons.arrow_back_ios),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              width: 200,
              height: 300,
              child: containedTabBarView,
            ),
          ),
          ElevatedButton(
            onPressed: () => key.currentState?.next(),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

class TripCardUpdat extends GetView<ServicesScreenController> {
  const TripCardUpdat({super.key, required this.trip, this.onlyShow = false});

  final Trips trip;
  final bool? onlyShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (!onlyShow!) {
            // await controller.endBootmSheetBookingTrip(trip);
            await controller.goToScreanBeneficiares(trip);
          }
        },
        child: DefaultCountainer(
          colorShadow: Get.theme.colorScheme.primary,
          height: 150,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // SizedBox(
                    //     height: 50,
                    //     width: MediaQuery.of(context).size.width,
                    // child:
                    Center(
                        child: trip.category!.idCategoryMain == 9 ||
                                trip.category!.idCategoryMain == 12
                            ? DefaultIcon.svg(
                                path: 'icons/plane1.svg',
                                width: 30,
                                height: 30,
                                color: Get.theme.colorScheme.primary,
                              )
                            : trip.category!.idCategoryMain == 10 ||
                                    trip.category!.idCategoryMain == 7
                                ? DefaultIcon.svg(
                                    path: 'icons/bus.svg',
                                    width: 30,
                                    height: 30,
                                    color: Get.theme.colorScheme.primary,
                                  )
                                : DefaultIcon.svg(
                                    path: 'icons/boat.svg',
                                    width: 30,
                                    height: 30,
                                    color: Get.theme.colorScheme.primary,
                                  )),
                    const Spacer(),
                    DataWithLebal(
                        lebal: LocaleKeys.trip_method.tr,
                        data: controller.category.value!.subCategory!
                            .firstWhere((element) =>
                                element.idCategoryMain ==
                                trip.category!.idSubCategory)
                            .nameCategoryMain!),
                    const Spacer(),

                    DataWithLebal(
                        lebal: 'طريقة الرحلة',
                        data: trip.category!.nameCategoryMain!),
                    const Spacer(),

                    DataWithLebal(
                      lebal: LocaleKeys.trip_company.tr,
                      data: trip.company!.name!,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          DataWithoutLebal(data: trip.fromCity!.name),
                          Expanded(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                  top: 33,
                                  child: DottedLine(
                                    lineLength: 150,
                                  )),
                              trip.category!.idCategoryMain == 9 ||
                                      trip.category!.idCategoryMain == 12
                                  ? Positioned(
                                      top: 0,
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: DefaultIcon.svg(
                                          path: 'icons/plane_run.svg',
                                          color: Get.theme.colorScheme.primary,

                                          // color: Get.theme.colorScheme.secondary,
                                        ),
                                      ),
                                    )
                                  : trip.category!.idCategoryMain == 10 ||
                                          trip.category!.idCategoryMain == 7
                                      ? Positioned(
                                          top: -2,
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: DefaultIcon.svg(
                                                path: 'icons/busrun.svg',
                                                color: Get
                                                    .theme.colorScheme.primary,

                                                // color: Get.theme.colorScheme.secondary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Positioned(
                                          top: -2,
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: DefaultIcon.svg(
                                                path: 'icons/boat_run.svg',
                                                color: Get
                                                    .theme.colorScheme.primary,

                                                // color: Get.theme.colorScheme.secondary,
                                              ),
                                            ),
                                          ),
                                        )
                            ],
                          )),
                          DataWithoutLebal(data: trip.toCity!.name)
                        ],
                      ),
                    ),
                    Expanded(
                        child: DataWithLebal(
                            lebal: LocaleKeys.trip_dateAndTimeSeats.tr,
                            data: trip.getDateGo ?? 'no limited')),
                    Expanded(
                        child: DataWithLebal(
                            lebal: 'وقت الرحلة',
                            data: trip.timeLeave!.format(context))),
                    Expanded(
                        child: DataWithLebal(
                      lebal: 'السعر',
                      data: trip.price!.toString() +
                          ' '.toString() +
                          trip.currencie!.name,
                    )),
                    if (controller.isCurrenc != null)
                      Expanded(
                          child: DataWithLebal(
                        lebal: controller.isCurrenc!.name,
                        data: controller
                            .convertCurrence(
                              trip.price!,
                              trip.currencie!,
                            )
                            .toString(),
                      )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DataWithoutLebal extends StatelessWidget {
  const DataWithoutLebal({
    super.key,
    required this.data,
  });

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Text(data ?? '');
  }
}

class DataWithLebal extends StatelessWidget {
  const DataWithLebal({
    super.key,
    required this.lebal,
    required this.data,
  });
  final String lebal;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lebal + DataConst.comme + data,
          style: Get.textTheme.headlineMedium,
        )
      ],
    );
  }
}
