import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sports_101/Data/Models/leagues/leagues.dart';

import '../../Shared/app_constant.dart';

class LeaguesRepo {
  Future<LeagueResponse?> getLeagues(int countryid) async {
    try {
      // var url = Uri.https(
      //     'apiv2.allsportsapi.com',
      //     '/football/?met=Leagues&APIkey=1b64ec96ab3f68ed63e0f33960291ebf491cf97ef83a0909752e889603102c6e&countryId=1',
      //     {'q': '{http}'});

      // var response = await http.get(url);

      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=$apiKey&countryId=$countryid"));
      Map<String, dynamic> decoderesponse = json.decode(response.body);
      if (response.statusCode == 200) {
        //print("Leagues Response : $decoderesponse");
        LeagueResponse data = await LeagueResponse.fromJson(decoderesponse);
        print("Leagues Response : $data");
        return LeagueResponse.fromJson(decoderesponse);
      } else {
        return null;
      }
    } catch (error) {
      print("Error : $error");
    }
    return null;
  }
}
