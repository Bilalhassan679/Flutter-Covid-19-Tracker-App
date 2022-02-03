
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkMode extends GetxController{


  var value1 = true.obs;
  bool toggleValue=false;
  ///by default it is true
  ///made a method which will execute while switching
  // changemode() {
  //   darkMode=darkMode!;
  //    ///notify the value or update the widget value
  // }


  togglefunc()
  {
    toggleValue=!toggleValue;
  }
}
