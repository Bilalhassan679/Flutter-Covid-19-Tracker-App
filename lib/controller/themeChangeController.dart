import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeChangeController extends GetxController{
  final themeValue1=false.obs;

  final box = GetStorage();
  var s = false.obs;


  static ThemeChangeController get to=>Get.find<ThemeChangeController>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initiateTheme();
  }


  setTheme(bool themeValue2){
    print('SetTheme $themeValue1');
    themeValue1(themeValue2);
  }

  initiateTheme()
  {
    s(GetStorage().read('themeChange'));
    print(' intiate theme ---> ${s.value}');
  }

  themechange(val)
  {
    s(val);
    // s.value = val;
    box.write('themeChange', val);

    print("theme change ----> ${s.value}");
  }

}