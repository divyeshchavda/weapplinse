import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketcoach/Week%209/pn.dart';
import 'package:pocketcoach/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String? payload;
  Timer? notificationTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      // ...
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain('id_2', 'Action 2', options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.destructive}),
            DarwinNotificationAction.plain('id_3', 'Action 3', options: <DarwinNotificationActionOption>{DarwinNotificationActionOption.foreground}),
          ],
          options: <DarwinNotificationCategoryOption>{DarwinNotificationCategoryOption.hiddenPreviewShowTitle},
        ),
      ],
    );

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleNotificationTap();
      },
    );
  }

  void handleNotificationTap() {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => pn()));
  }

  Future<void> request() async {
    var status2 = await Permission.scheduleExactAlarm.status;
    if (!status2.isGranted) {
      await Permission.scheduleExactAlarm.request();
    }
    var status = await Permission.notification.status;
    if (status.isDenied) {
      status = await Permission.notification.request();
    }
    if (status.isGranted) {
      return;
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Permission permanently denied. Enable it in app settings.'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification permission denied.')));
    }
  }

  Future<void> showNotification() async {
    var androidDetails = AndroidNotificationDetails('channel_id', 'channel_name', importance: Importance.high, priority: Priority.high);

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Hello!', // Notification Title
      'This is a local notification', // Notification Body
      platformDetails,
      payload: 'item x', // Optional payload
    );
  }

  Future<void> showscheduledNotification(int a) async {
    Future.delayed(Duration(seconds: a), () async {
      var androidDetails = AndroidNotificationDetails('channel_id', 'channel_name', importance: Importance.high, priority: Priority.high, ticker: 'ticker');

      var platformDetails = NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        'Hello!', // Notification Title
        'This is a local notification', // Notification Body
        platformDetails,
        payload: 'item x', // Optional payload
      );
    });
  }

  void periodic() async {
    var androidDetails = AndroidNotificationDetails('channel_id1', 'channel_name1', importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var platformDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1, // Notification ID
      'Periodic Notification!', // Notification Title
      'This is a local notification',
      RepeatInterval.everyMinute,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Periodic Notification Set"), duration: Duration(milliseconds: 500)));
  }

  void schedule(tz.TZDateTime d) async {
    var androidDetails = AndroidNotificationDetails('channel_id1', 'channel_name1', importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var platformDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(2, "Schedule Notification", "Text Notification", d, platformDetails, androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
    print("setted");
  }

  // void startPeriodicNotifications() {
  //   notificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     showNotification();
  //   });
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("5-second notifications started!")),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Local Notification")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.black),
                onPressed: () async {
                  showNotification();
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString("payload", "1");
                },
                child: Text("Show Notification", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.black),
              onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                var payload = prefs.get("payload");
                print(payload);
                if (payload == "1") {
                  await flutterLocalNotificationsPlugin.cancelAll();
                  await prefs.remove("payload");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification Is Canceled"), duration: Duration(milliseconds: 500)));
                } else if (payload == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification Is Not Activated"), duration: Duration(milliseconds: 500)));
                }
              },
              child: Text("Cancel Notification", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.black),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));

                if (pickedDate != null) {
                  // Pick Time
                  TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                  if (pickedTime != null) {
                    // Combine Date and Time
                    DateTime dateTime2 = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
                    DateTime dateTime1 = DateTime.now();
                    Duration difference = dateTime2.difference(dateTime1);
                    int secondsBetween = difference.inSeconds;
                    print("Difference in seconds: $secondsBetween");
                    tz.Location location = tz.getLocation("Asia/Kolkata");
                    print(tz.TZDateTime.now(location));
                    print(location);
                    if (secondsBetween > 0) {
                      schedule(tz.TZDateTime(location, pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute));
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString("payload", "1");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Schedule Can Not in Past"), duration: Duration(milliseconds: 500)));
                    }
                  }
                }
              },
              child: Text("Scheduled Notification", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.black),
              onPressed: () async {
                periodic();
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("payload", "1");
              },
              child: Text("Periodic Notification", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
