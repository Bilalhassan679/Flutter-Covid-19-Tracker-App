import 'dart:async';

import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/controller/themeChangeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'country_list_screen.dart';

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  _WorldStateState createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  ThemeChangeController themeChangeController = Get.put(ThemeChangeController());
  StatesServices statesServices = StatesServices();
  final box = GetStorage();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.to(() => const WorldState()));
  }
// /hkl

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff428544),
    const Color(0xff425111),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: statesServices.fetchWorldAState(),
              builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return
                       Container(
                         height: MediaQuery.of(context).size.height,
                         child: Center(
                             child: SpinKitFadingCircle(
                               controller: _controller,
                               color: box.read('key') == true?Colors.black:Colors.white,
                               size: 50.0,
                             )),
                       );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Switch.adaptive(
                          value: box.read('key') ?? false,
                          onChanged: (value) {
                            box.write(
                                'key',
                                box.read('key') ?? false);
                            var themeType = box.read('key') == true
                                ? ThemeData.dark()
                                : ThemeData.light();
                            setState(() {
                              box.write('key', value);
                              Get.changeTheme(themeType);
                              print(box.read('key'));
                              print(themeType);
                            });
                          }),
                      PieChart(
                        dataMap: {
                          "Total": double.parse(snapshot.data!.cases!.toString()),
                          'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                          "death": double.parse(snapshot.data!.deaths!.toString()),

                        },
                        chartRadius: MediaQuery.of(context).size.width/2.5,
                chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true
                ),
                        animationDuration:
                            const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,

                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        colorList: colorList,
                        ringStrokeWidth: 8,
                      ),
                      Card(
                        child: Column(
                          children: [
                            ReusableRow(
                              title: 'Total',
                              value: snapshot.data!.cases!.toString(),
                            ),
                            ReusableRow(
                              title: 'Deaths',
                              value: snapshot.data!.deaths!.toString(),
                            ),
                            ReusableRow(
                              title: 'Recovered',
                              value: snapshot.data!.recovered!.toString(),
                            ),
                            ReusableRow(
                              title: 'Active',
                              value: snapshot.data!.active!.toString(),
                            ),
                            ReusableRow(
                              title: 'Critical',
                              value: snapshot.data!.critical!.toString(),
                            ), ReusableRow(
                              title: 'Today Deaths',
                              value: snapshot.data!.todayDeaths!.toString(),
                            ),ReusableRow(
                              title: 'Today Recovered',
                              value: snapshot.data!.todayRecovered!.toString(),
                            ),



                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Center(
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                 Get.to(const CountryListScreen());
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  fixedSize: const Size(380, 40),
                                  primary: Colors.green),
                              child: const Text("Track Countries")))
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title;
  String value;
  ReusableRow({Key? key, required this.value, required this.title})
      : super(key: key);

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
