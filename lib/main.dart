import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weapplinse/Week%201/task7-3.dart';
import 'package:weapplinse/Week%202/task2-1-1.dart';
import 'package:weapplinse/Week%203/task3-2-1.dart';
import 'package:weapplinse/week.dart';

import 'Week 1/task7-2.dart';
import 'Week 1/task7.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MaterialApp
      (initialRoute: "/",
        routes: {
        "/":(context)=>week(),
        "/task72":(context)=>task72(),
        "/task73":(context)=>task73(),
        "/task7":(context)=>task7()
    },debugShowCheckedModeBanner: false,
        ));
  });
}
