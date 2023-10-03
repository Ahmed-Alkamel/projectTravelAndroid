import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projecttravel/app/theme/color.dart';

import '../../../Helper/websocket_helper.dart';
import '../../../models/basic/chat.dart';
import '../../../models/basic/customer.dart';
import '../../../models/basic/requst_service_booking.dart';
import '../../../models/basic/state_request.dart';
import '../../../models/basic/user_request.dart';
import '../../../repository/user_request_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../services/websockt_Services.dart';
import '../../home/views/home_view.dart';
import '../../widgets/default_widget.dart';
import '../views/beneficicares_view.dart';

import '../views/customer_request_view.dart';

class MainScreanController extends GetxController {
  final currentIndexNavigatorBar = 0.obs;
  XFile? image;
  File? fileCurrent;
  StreamSubscription<Chat>? subscription;

  List<Widget> pages = [
    HomeView(),
    const CustomerRequestView(),
    const BeneficicaresView(),
    // const ChatView()
  ];
  List<String> titlePage = const [
    'القائمة الرئسية',
    "طلباتي",
    "المستفيدين",
    // 'مراسلة الدعم الفني'
  ];

  UserRequestRepository? _userRequestRepository;

  User? currentUser = Get.find<AuthUserService>().user;
  List<UserRequest>? requsstData;
  List<UserRequest>? userRequest;
  List<UserRequest>? upDataStat;
  List<DataInputRequrment> editeDataInput = [];
  // WebsocketBaseClassServices websocket = Get.find<WebsocketBaseClassServices>();
  DataInputRequrment? selectInputData;
  RxList<StateRequest> stateRequest = RxList();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final contrllerButtomNavbar = PersistentTabController(initialIndex: 0);
  @override
  void onInit() async {
    _userRequestRepository = UserRequestRepository();

    await loadData();
    // await WebsocketChannalApp.init();
    // final subscriptionMessage = {
    //   'event': 'pusher:subscribe',
    //   'data': {'channel': 'public-CustomerRequst'}
    // };
    // WebsocketChannalApp.channal.sink.add(json.encode(subscriptionMessage));
    // dataRequestStream();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   // websocket.closeChannal();
  //   super.onClose();
  // }

  loadData() async {
    await refreshUser();
    if (currentUser != null) {
      userRequest =
          await _userRequestRepository!.getRequestById(currentUser!.idCus!);

      requsstData = userRequest;
      stateRequest.value = await _userRequestRepository!.getAllStatRequest();
      // configeWebsocket();

      // linstTochat();
    }
  }

  Future<void> _cropImage() async {
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'تعديل ابعاد الصورة',
              toolbarColor: Get.theme.colorScheme.primary,
              backgroundColor: Get.theme.colorScheme.secondary,
              cropFrameColor: Get.theme.colorScheme.primary,
              statusBarColor: Get.theme.colorScheme.secondary,
              toolbarWidgetColor: Get.theme.colorScheme.secondary,
              activeControlsWidgetColor: Get.theme.colorScheme.primary,
              cropGridColor: Get.theme.colorScheme.primary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );
      if (croppedFile != null) {
        // setState(() {
        //   this.imageCrop = croppedFile;
        // });
      }
    }
  }

  pickImage(bool isCamera) async {
    try {
      var imageitem = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (imageitem != null) {
        image = imageitem;
        await _cropImage();
        Get.back();
        // setState(() {});
      }
    } on PlatformException catch (e) {
      Get.log(e.message!);
    }
  }

  filePiicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileCurrent = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  refreshUser() async {
    await Get.find<AuthUserService>().refresh();
    currentUser = Get.find<AuthUserService>().user;
  }

  // configeWebsocket() {
  //   // websocket.connect();
  //   websocket.subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
  //       data: {'channel': 'public-updataRequestCustomer'},
  //       event: 'pusher:subscribe'));
  //   websocket.listenToEventSpecific(
  //       'App\\Events\\updataStateRequestcustomerEvent', currentUser!.idCus!);
  //   websocket.streamController.stream.listen((event) async {
  //     upDataStat = event['info'] == null
  //         ? null
  //         : List<UserRequest>.from(
  //             (event['info'] as List<dynamic>).map<UserRequest?>(
  //               (x) => UserRequest.fromMap(x as Map<String, dynamic>),
  //             ),
  //           );

  //     if (upDataStat != null) {
  //       userRequest = upDataStat;
  //       requsstData = upDataStat;

  //       update(['bodyCustomerRequest']);
  //       await NotificationsService.showNotification(
  //           title: 'تم تلقي استجابة على الطلب',
  //           body: 'تم تلقي استجابة لطلبك من قبل ادراة التطبيق',
  //           actionButton: [
  //             NotificationActionButton(
  //                 key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
  //           ]);
  //     }
  //   });
  // }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      cutomeItemButtomNavbar(
        index: 0,
        path: 'icons/homeone.svg',
        title: "الصفحة الرئيسية",
      ),
      cutomeItemButtomNavbar(
        index: 1,
        path: 'icons/evidence.svg',
        title: "طلباتي",
      ),
      cutomeItemButtomNavbar(
        index: 2,
        path: 'icons/people.svg',
        title: "المستفيدين",
      ),
      // cutomeItemButtomNavbar(
      //   index: 3,
      //   path: 'icons/chat.svg',
      //   title: "الدعم الفني",
      // ),
    ];
  }

  PersistentBottomNavBarItem cutomeItemButtomNavbar(
      {required String path, String? title, required int index}) {
    return PersistentBottomNavBarItem(
        icon: DefaultIcon.svg(
          path: path,
          width: 40,
          height: 40,
          color: index == currentIndexNavigatorBar.value
              ? Get.theme.colorScheme.secondary
              : Colors.black,
        ),
        title: title,
        activeColorPrimary: Get.theme.colorScheme.secondary,
        inactiveColorPrimary: Colors.black,
        textStyle: Get.textTheme.headlineMedium!.merge(TextStyle(
            fontSize: index == currentIndexNavigatorBar.value ? 15 : 14,
            color: index == currentIndexNavigatorBar.value
                ? DefaultColor.textPrimary
                : DefaultColor.textSecandry)));
  }

  void login() {}
  logout() async {
    Get.find<AuthUserService>().logout();
    await Get.offAllNamed(Routes.MAIN_SCREAN);
  }

  // dataRequestStream() {
  //   WebsocketChannalApp.channal.stream.listen((message) {
  //     final data = json.decode(message);
  //     if (data['event'] == 'App\\Events\\RequestCustomerControllEvent') {
  //       // print(data);
  //       CustomerRequestStreamModel customer =
  //           CustomerRequestStreamModel.fromMap(data);
  //       requsstData = customer.data;
  //       update(['request']);
  //     }
  //   });
  // }
  Future alertChoiseImagePicker() => Get.defaultDialog(
        title: 'مكان الصورة',
        titleStyle: Get.textTheme.titleMedium!
            .merge(TextStyle(color: Get.theme.colorScheme.primary)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await pickImage(true);
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
              onTap: () async {
                await pickImage(false);
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

  void changeNavigatorBar(int i) {
    currentIndexNavigatorBar.value = i;
    update(['bottomNavigationBar', 'bodyOfMainScreen']);
  }

  void shStatRequset(StateRequest e) {
    requsstData = userRequest!.where((element) => element.state! == e).toList();
    update(['bodyCustomerRequest']);
  }

  void test() {
    print('hello');
  }

  int addItemEditeAndIndex(DataInputRequrment dataInputRequrment) {
    if (editeDataInput.any((element) => element == dataInputRequrment)) {
      selectInputData = DataInputRequrment.fromMap(dataInputRequrment.toMap());
      return editeDataInput
          .indexWhere((element) => element.id! == dataInputRequrment.id!);
    } else {
      selectInputData = DataInputRequrment.fromMap(dataInputRequrment.toMap());
      editeDataInput.add(dataInputRequrment);
      return editeDataInput
          .indexWhere((element) => element.id == dataInputRequrment.id!);
    }
  }

  bool checkAdjestExitShowEdite(
      bool selectFromBottonBack,
      bool selectFromBottonSave,
      int index,
      DataInputRequrment dataInputRequrment) {
    bool temp = editeDataInput.isNotEmpty;
    if (temp) {
      if (selectFromBottonSave) {
        if (editeDataInput[index] == selectInputData!) {
          editeDataInput.removeAt(index);
          selectInputData = null;
          return true;
        } else {
          selectInputData = null;
          return true;
        }
      } else if (selectFromBottonBack) {
        editeDataInput.removeAt(index);
        selectInputData = null;
        return true;
      } else {
        if (editeDataInput[index] == selectInputData!) {
          selectInputData = null;
          editeDataInput.removeAt(index);

          return true;
        } else {
          return false;
        }
      }
    } else {
      selectInputData = null;
      return true;
    }
  }

  void updatalogoApp() {
    update(['logoApp']);
  }

  // void linstTochat() {
  //   if (!islisent) {
  //     // websocket
  //     //     .listenToEventSpecific('App\\Events\\updataStateRequestcustomerEvent',
  //     //         currentUser!.idCus!)!
  //     //     .listen((event) async {
  //     //   upDataStat = event['info'] == null
  //     //       ? null
  //     //       : List<UserRequest>.from(
  //     //           (event['info'] as List<dynamic>).map<UserRequest?>(
  //     //             (x) => UserRequest.fromMap(x as Map<String, dynamic>),
  //     //           ),
  //     //         );
  //     //
  //     //   if (upDataStat != null) {
  //     //     userRequest = upDataStat;
  //     //     requsstData = upDataStat;
  //     //
  //     //     update(['bodyCustomerRequest']);
  //     //     //     await NotificationsService().showNotification(
  //     //     //         title: 'تم تلقي استجابة على الطلب',
  //     //     //         body: 'تم تلقي استجابة لطلبك من قبل ادراة التطبيق',
  //     //     //         actionButton: [
  //     //     //           NotificationActionButton(
  //     //     //               key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
  //     //     //         ],
  //     //     //         channalKey: DataConst.channelUpdataState,
  //     //     //         id: -1);
  //     //   }
  //     // });
  //     websocketChat.connect(SubsicrubeChannel.channelChat);
  //     websocketChat
  //         .listenToEventSpecific('App\\Events\\ChatEvent', currentUser!.idCus!)!
  //         .listen((event) {
  //       Chat chat = Chat.fromMap(event);
  //       chats.add(chat);
  //       isNewMassage.value = true;
  //     });
  //     islisent = true;
  //   }
  // }
}

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title!,
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
