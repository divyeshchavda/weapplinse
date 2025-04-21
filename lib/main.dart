import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pocketcoach/Week%209/branch.dart';
import 'package:pocketcoach/Week%209/pn.dart';
import 'package:pocketcoach/week.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'Week 1/task7-2.dart';
import 'Week 1/task7-3.dart';
import 'Week 1/task7.dart';
import 'Week 7/const.dart';
import 'Week_12/Provider_helper.dart';
import 'Week_12/counter_state.dart';
import 'noti.dart';

List a = [1, 2, 3, 4, 5, 6];
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublicedKey;
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  FlutterBranchSdk.init();
  tz.initializeTimeZones();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print("FCM Token: $fcmToken");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);
  await NotificationService().init();
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true),
    ),
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      navigatorKey.currentState?.pushNamed("/pn");
    },
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runZonedGuarded<Future<void>>(() async {
      runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => counter()), ChangeNotifierProvider(create: (context) => CounterState())], child: MyApp()));
    }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          initialRoute: "/",
          routes: {
            "/": (context) => week(),
            "/task7": (context) => task7(),
            "/task72": (context) => task72(),
            "/task73": (context) => task713(),
            '/pn': (context) => const pn(),
            '/dynamic': (context) => branch(),
          },
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> checkForTerminatedNotification() async {
  final NotificationAppLaunchDetails? details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  bool? wasLaunchedByNotification = details?.didNotificationLaunchApp;
  print("Notification: $wasLaunchedByNotification");

  if (wasLaunchedByNotification == true) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed("/pn");
    });
    wasLaunchedByNotification = null;
    print(wasLaunchedByNotification);
  }
}
