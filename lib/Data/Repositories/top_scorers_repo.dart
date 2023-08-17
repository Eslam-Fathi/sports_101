// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sports_101/Shared/app_constant.dart';

import '../Models/Top_Scorers_model/top_scorers_model/top_scorers_model.dart';

class TopScorersRepo {
  Future<TopScorersModel?> getTopScorers(int leagueid) async {
    try {
      var response = await http.get(
        Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&leagueId=$leagueid&APIkey=$apiKey&met=Topscorers",
        ),
      );

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TopScorersModel data = TopScorersModel.fromJson(deCodedResponse);
        return data;
      } else {
        print('Request Failed!');
        return null;
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }
}
