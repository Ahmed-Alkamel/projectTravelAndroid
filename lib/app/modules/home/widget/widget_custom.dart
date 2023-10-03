import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/basic/category_secondry.dart';
import '../../../models/basic/service.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/default_widget.dart';
import '../controllers/home_controller.dart';

defaultBottomSheet({required String titleBottom, required List<Service> item}) {
  return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(child: DefaultText(titleBottom)),
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  Service servie = item[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.sunny,
                    ),
                    title: DefaultText(servie.name!),
                    //subtitle: DefaultText(ite),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                defaultButton(
                    onPressed: () {
                      Get.back();
                    },
                    isResponseve: false,
                    isIcon: false,
                    lable: 'تم',
                    width: 150)
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white);
}

defaultShowDialog({
  required String title,
  required List<CategorySecondry?> itmes,
}) {
  HomeController controller = Get.put(HomeController());
  Get.defaultDialog(
    title: title,
    content: Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: itmes
                .map((e) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: defaultButton(
                            onPressed: () {
                              controller.tempSevices = controller.tempSevices!
                                  .where((element) => element.category == null)
                                  .toList();

                              Get.back();
                              Get.toNamed(Routes.SERVICES_SCREEN);
                            },
                            isResponseve: false,
                            isIcon: false,
                            lable: e!.name!),
                      ),
                    ))
                .toList(),
          ),
        ),
        const Spacer()
      ],
    ),
  );
}
