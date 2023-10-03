import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:projecttravel/app/models/basic/customer.dart';
import 'package:projecttravel/app/services/websockt_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/diohelper.dart';
import '../Helper/shard_prefernces.dart';
import '../Helper/websocket_helper.dart';
import '../data/local/local_data.dart';
import '../models/basic/notification_app.dart';
import 'notification_services.dart';

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();

  DartPluginRegistrant.ensureInitialized();
  var shard = await SharedPreferences.getInstance();
  var dio = DioHelpper();
  int? idUser;
  StreamSubscription<dynamic>? listen;
  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult connectivityResult) async {
    var websocket = WebsocketBaseClassServices();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      if (listen == null || listen!.isPaused) {
        await websocket.connect(SubsicrubeChannel.notification);
        idUser = shard.getInt(User.idShardPref);
        listen = websocket
            .listenToEventSpecific(
                'App\\Events\\NotificationEvent', idUser ?? 0)!
            .listen((event) async {
          idUser = shard.getInt(User.idShardPref);
          NotificationApp message = NotificationApp.fromMap(event);
          await NotificationsService().showNotification(
              title: message.message!.titleNotification,
              body: message.message!.body,
              actionButton: [
                NotificationActionButton(
                    key: 'id', label: 'عرض', actionType: ActionType.KeepOnTop)
              ],
              channalKey: DataConst.channelUpdataState,
              id: -1);
          await dio.initialbackgroud();
          await dio.postDataBackgroud(
              path: 'notification/recive', data: {'id': message.id});
        }, onError: (value) async {
          // print(value);
        }, onDone: () {});
      }
    } else {
      // websocket.closeChannal();
      // listen!.pause();
      websocket.closeChannal();
      listen!.pause();
    }
  });
}

class BackgroundServices {
  BackgroundServices() {
    // fristOpen = ShardHelpar.shard.getBool('fristOpen') ?? false;
    // fristOpen = false;
  }
  // late bool fristOpen;

  Future<void> initializeService() async {
    // if (true) {
    // if (!fristOpen) {
    final service = FlutterBackgroundService();

    await service.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStartOnBoot: true,
          // auto start service
          autoStart: true,
          isForegroundMode: false,

          notificationChannelId: DataConst.channelUpdataState,
        ),
        iosConfiguration: IosConfiguration());
  }
}
