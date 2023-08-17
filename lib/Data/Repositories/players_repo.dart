// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sports_101/Shared/app_constant.dart';
import '../Models/Players/players_model.dart';

class PlayersRepo {
  Future<PlayersModel?> getPlayersData(int teamid, String playername) async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Players&APIkey=$apiKey&teamId=$teamid&playerName=$playername"));
      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        PlayersModel data = PlayersModel.fromJson(deCodedResponse);
        // print(data.result.length);
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
