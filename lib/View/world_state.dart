import 'dart:async';

import 'package:covid_tracker/controller/themeChangeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  _WorldStateState createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  final box=GetStorage();
  late final AnimationController _controller=AnimationController(vsync: this,duration:const Duration(seconds: 3))..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),() => Get.to(() => const WorldState()));

  }
// /hkl

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList=<Color> [
    const Color(0xff4285f4),
    const Color(0xff428544),
    const Color(0xff425111),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           Switch.adaptive (
                  value: box.read('key')!=null ?box.read('key'):false,
                  onChanged: (value)  {
                    box.write('key', box.read('key')!=null ?box.read('key'):false);
                    var themeType = box.read('key') == true ? ThemeData.dark() :ThemeData.light();
                    setState(() {
                      box.write('key',value);
                      Get.changeTheme(themeType);
                      print(box.read('key'));
                      print(themeType);
                    });

                  }
              ),

            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: PieChart(dataMap: const {
                "Total":45,
                'Recovered':15,
                "death":25,
              },
              animationDuration: const Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left
                ),
                colorList: colorList,
                ringStrokeWidth: 8,

              ),
            ),
            Card(
              child: Column(
                children: [
                  ReusableRow(title:'Data' ,value: '300',),
                  ReusableRow(title:'Data' ,value: '300',),
                  ReusableRow(title:'Data' ,value: '300',)
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            Center(child: ElevatedButton(onPressed: () {
              setState(() {
                // print(themeValue);
                print(box.read('key'));
              });

            },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),fixedSize: const Size(380, 40),primary: Colors.green ), child: const Text("Track Countries")))
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title;
  String value;
  ReusableRow({Key? key,required this.value,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        )
      ],
    );
  }
}


