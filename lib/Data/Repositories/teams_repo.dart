// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sports_101/Shared/app_constant.dart';

import '../Models/Teams_model/teams_model.dart';

class LeagueTeamsRepo {
  Future<TeamsModel?> getAllTeams(int? leagueId, String? searchTeam) async {
    try {
      var url =
          "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=$leagueId&APIkey=$apiKey";
      if (searchTeam != null && searchTeam.isNotEmpty) {
        url += "&teamName=$searchTeam";
      }
      var response = await http.get(Uri.parse(url));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TeamsModel data = TeamsModel.fromJson(deCodedResponse);

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