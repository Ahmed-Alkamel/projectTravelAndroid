import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/Helper/diohelper.dart';
import 'app/Helper/permission_handler_helper.dart';
import 'app/Helper/shard_prefernces.dart';
// import 'app/data/api/websocket.dart';
import 'app/data/api/laravel_api.dart';
import 'app/providers/database.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_services.dart';
import 'app/services/notification_services.dart';
import 'app/services/sevice_background.dart';
import 'app/translations/locale.dart';
import 'app/services/global_services.dart';
import 'app/theme/setting.dart';
import 'app/theme/color.dart';

// @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() async {
//   Workmanager().executeTask((task, inputData) async {
//     // WebsocketChannalHelper.channal!.stream.listen((event) {
//     //   Get.find<NotificationsService>().showNotificationForgroand(
//     //       title: 'ahmed',
//     //       body: 'ahmed',
//     //       id: 1,
//     //       channalKey: DataConst.channelUpdataState);
//     // }

//     // );
//     switch (task) {
//       case 'websocketNotification1s':
//         {}

//         break;

//       default:
//         {
//           // print('object');
//         }
//     }

//     return Future.value(true);
//   });
// }

//
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: DefaultColor.primaryColor));
  await GetStorage.init();
  await Get.putAsync(() => LaravelApi().init());
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => AuthUserService().init());
  // await Get.putAsync(
  //     () => WebsocketBaseClassServices().connect(SubsicrubeChannel.all));
  await Get.putAsync(() => NotificationsService().initializeNotification());
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  DioHelpper.init();
  await ShardHelpar.init();
  await PermissionHelper().initi();
  DefaultColor.init();
  await DatabaseServices().initDatabase();

  await BackgroundServices().initializeService();
  SettingsService setting = SettingsService();
  await setting.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: setting.getLightTheme(),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'), // English
      //   Locale('ar'), // Spanish
      // ],
      locale: const Locale('ar'),
      translations: AppTranslation(),
    ),
  );
  FlutterNativeSplash.remove();
}
