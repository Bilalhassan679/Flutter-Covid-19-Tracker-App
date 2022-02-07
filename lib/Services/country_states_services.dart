import 'dart:convert';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;


class ContryStatesServices {

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