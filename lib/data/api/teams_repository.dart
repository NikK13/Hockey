import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:hockey/data/model/team.dart';

class TeamsRepository{
  static Future<dynamic> fetchAllTeams() async{
    Response? res;
    try{
      res = await Client().get(Uri.parse("https://api.npoint.io/46886d0500d4c34b4576"));
      debugPrint("RESPONSE CODE: ${res.statusCode}");
      if(res.statusCode != 200){
        return res.body.toString();
      }
      else {
        return fetchJsonToList(res.body);
      }
    }
    catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  static List<Team> fetchJsonToList(String response){
    final data = List<Team>.from(json.decode(response)['teams'].map((place) => Team.fromJson(place)));
    return data;
  }
}