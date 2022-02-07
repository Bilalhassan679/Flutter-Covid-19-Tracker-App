

import 'package:covid_tracker/Services/country_states_services.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController searchController=TextEditingController();
  final box=GetStorage();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(appBar: AppBar(
        elevation:0,
      leading: BackButton(color:  box.read('key') == true ? Colors.white:Colors.grey.shade100,),
    ),
    body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          onChanged: (value){setState(() {

          });},
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            hintText: 'Search with Country Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0)
            )
          ),
        ),
      ),
      Expanded(
        child: FutureBuilder(
            future: statesServices.fetchCountryAState(),
            builder: (BuildContext context ,AsyncSnapshot<List<dynamic>> snapshot)
        {
          if(!snapshot.hasData)
          {
            return Shimmer.fromColors(child:ListView.builder(
                itemCount: 4,
                itemBuilder: (context ,index)
                {
                  return Column(
                    children: [
                      ListTile(
                        title:Container(height: 10,width: 89,color: Colors.white,),
                        subtitle:Container(height: 10,width: 89,color: Colors.white,),
                        leading: Container(height: 50,width: 50,color: Colors.white,),
                      )
                    ],
                  );
                })  , baseColor: Colors.grey.shade700, highlightColor: Colors.grey.shade100);
          }
          else {

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context ,index)
                {
                String findCountryName=snapshot.data![index]['country'];
                      
                if(searchController.text.isEmpty){
                  return Column(
                    children: [
                      InkWell(
                        onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailScreen(image:snapshot.data![index]['countryInfo']['flag'] , name:snapshot.data![index]['country'], totalCases: snapshot.data![index]['cases'], todayDeaths: snapshot.data![index]['todayDeaths'], todayRecovered: snapshot.data![index]['todayRecovered'])));},
                        child: ListTile(
                          title:Text(snapshot.data![index]['country']),
                          subtitle:Text(snapshot.data![index]['cases'].toString()),
                          leading: Image(
                              height:50,width: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                        ),
                      )
                    ],
                  );
                }
                else if(findCountryName.toLowerCase().contains(searchController.text.toLowerCase())){
                  return Column(
                    children: [
                      InkWell(
                        onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailScreen(image:snapshot.data![index]['countryInfo']['flag'] , name:snapshot.data![index]['country'], totalCases: snapshot.data![index]['cases'], todayDeaths: snapshot.data![index]['todayDeaths'], todayRecovered: snapshot.data![index]['todayRecovered'])));},
                        child: ListTile(
                          title:Text(snapshot.data![index]['country']),
                          subtitle:Text(snapshot.data![index]['cases'].toString()),
                          leading: Image(
                              height:50,width: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                        ),
                      )
                    ],
                  );

                }
                else return Container();
                });

          }
        }),
      )
      ],),
    );
  }
}
