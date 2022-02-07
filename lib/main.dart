
import 'package:covid_tracker/View/country_list_screen.dart';
import 'package:covid_tracker/View/getxPractice.dart';
import 'package:covid_tracker/View/modes_notify.dart';
import 'package:covid_tracker/View/splash_screen.dart';
import 'package:covid_tracker/View/world_state.dart';
import 'package:covid_tracker/controller/themeChangeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// light
// asycstorage !== null ? asyncstorage : light
// asyncstorage.saveitem('dj',light)


void main() async{
  await GetStorage.init();
  Get.put(ThemeChangeController());

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final box=GetStorage();
  // final themeChangeController =ThemeChangeController.to;

  final ThemeChangeController themeChangeController = Get.put(
    ThemeChangeController(),
  );

  MyApp({Key? key,}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return
      // Obx(
      // () =>
          GetMaterialApp(
      // child: GetMaterialApp(

        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData (
          // brightness: box.read('themeChange') == true ? Brightness.light :Brightness.dark,
          brightness: box.read('key') == true ? Brightness.light :Brightness.dark,
          // brightness: themeChangeController.s.value == true ? Brightness.light :Brightness.dark,
          primarySwatch: Colors.blue,

        ),

        // home: const SplashScreen(),
        home: SplashScreen(),
      );
    // );
}

}

