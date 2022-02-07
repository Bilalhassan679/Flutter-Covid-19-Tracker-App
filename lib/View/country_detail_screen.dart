import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class CountryDetailScreen extends StatelessWidget {
  final box=GetStorage();
  String image;
  String name;
  int totalCases,todayDeaths,todayRecovered;
  CountryDetailScreen({required this.image,required this.name,required this.totalCases,required this.todayDeaths,required this.todayRecovered, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(name.toString()),centerTitle: true,leading: BackButton(color:  box.read('key') == true ? Colors.white:Colors.grey.shade100,),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Card(child: Column(
                children: [
                  ReusableRow(value:name, title: 'Country Name'),
                  ReusableRow(value:totalCases.toString(), title: 'TotalCases'),
                  ReusableRow(value:todayDeaths.toString(), title: 'todayDeaths'),
                  ReusableRow(value:todayRecovered.toString(), title: 'todayRecovered'),
                ],
              )),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(image),
            ),

          ],
        )
      ],),
    );
  }
}
