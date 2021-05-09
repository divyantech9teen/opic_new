import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io' show Platform;

import 'package:rxdart/rxdart.dart';

class LocalNotifyManger {
  var initSetting;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  // _ImageViewState createState() => _ImageViewState();
  BehaviorSubject<ReceivedNotifaction> get didReciveLocalNotifacationSubject =>
      BehaviorSubject<ReceivedNotifaction>();

  LocalNotifyManger.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      requestIOSPermisson();
    }
    initialzePlatform();
  }

  requestIOSPermisson() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          badge: true,
          sound: true,
          alert: true,
        );
  }

  initialzePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('app_icon');
    var initSettingIos = IOSInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceivedNotifaction receivedNotifaction = ReceivedNotifaction(
              id: id, title: title, body: body, payload: payload);
          didReciveLocalNotifacationSubject.add(receivedNotifaction);
        });
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIos);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReciveLocalNotifacationSubject.listen((notifications) {
      onNotificationReceive(notifications);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.max, priority: Priority.high, playSound: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.show(
        0, "Test Demo", "Test Body", platformChannel,
        payload: "new Demo Notifcation");
  }

  Future<void> showScheduleNotification(DateTime dateTime) async {
    // var scheduleNotifcationDatatime = DateTime.now().add(Duration(seconds: 5));
    var scheduleNotifcationDatatime = dateTime;

    var androidChannel = AndroidNotificationDetails(
        "channelId 1", "channelName 1", "channelDescription 1",
        importance: Importance.max, priority: Priority.high, playSound: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        "Image download",
        "Image downloaded successfully",
        scheduleNotifcationDatatime,
        platformChannel,
        payload: "new Demo Notifcation");
  }

  Future<void> showRepeatedNotification() async {
    var androidChannel = AndroidNotificationDetails(
        "channelId 2", "channelName 2", "channelDescription 2",
        importance: Importance.max, priority: Priority.high, playSound: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        " Repated Test Demo",
        "Test Body",
        RepeatInterval.everyMinute,
        platformChannel,
        payload: "new Demo Notifcation");
  }
}

LocalNotifyManger localNotifyManger = LocalNotifyManger.init();

class ReceivedNotifaction {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotifaction(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
