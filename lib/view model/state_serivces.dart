import 'dart:convert';

import 'package:covid_19_app/models/world_state_model.dart';
import 'package:covid_19_app/view%20model/utills/app_url.dart';

import 'package:http/http.dart' as http;

class WorldStateServices {
  Future<WorldStateModel> getWorldState() async {
    var response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw 'something wrong';
    }
  }

  Future<List<dynamic>> getData() async {
    var response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw 'something wrong';
    }
  }
}
