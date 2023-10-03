import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/basic/service.dart';
import '../widgets/default_widget.dart';
import 'controllers/services_public_controller.dart';

Future bootomSheetBookingService(
    Service service, ServicesPublicController controller) {
  return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  service.name!,
                  style: Get.textTheme.titleLarge,
                ),
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
                    controller.isFamily.value
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
                    controller.isFamily.value
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

                        controller.endBootmSheetBookingServices(service);
                      }))
            ],
          ),
        ),
      ),
      backgroundColor: Get.theme.colorScheme.secondary);
}
