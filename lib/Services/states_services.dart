import 'dart:convert';
import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';

import 'package:http/http.dart' as http;


 class StatesServices {

  Future<WorldStatesModel> fetchWorldAState() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode==200)
      {
        var data=jsonDecode(response.body);
        print(data);
        return WorldStatesModel.fromJson(data);
      }
    else
      {
        throw Exception('Error');
      }

  }

  Future<List<dynamic>> fetchCountryAState() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryListApi));

    if(response.statusCode==200)
    {
      data=jsonDecode(response.body);
      print(data);

      return data;
    }
    else
    {
      throw Exception('Error');
    }

  }
}