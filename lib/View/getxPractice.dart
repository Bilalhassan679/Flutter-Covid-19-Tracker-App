import 'dart:async';

import 'package:covid_tracker/controller/themeChangeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class getxPractice extends StatelessWidget {

  final ThemeChangeController themeChangeController = Get.put(
    ThemeChangeController(),
  );
  final box = GetStorage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
            () =>
                Switch.adaptive(
                value: themeChangeController.s.value,
                // value: box.read('themeChange') ?? false,
                onChanged: (value){
                  themeChangeController.themechange(value);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}



