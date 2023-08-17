import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sports_101/Data/Models/leagues/leagues.dart';
import 'package:sports_101/Data/Repositories/leagues_repo.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit() : super(LeaguesInitial());

  LeagueResponse? leaguesResponse;
  Future<void> getLeagues(int countryId) async {
    LeaguesRepo().getLeagues(countryId).then((value) {
      if (value != null) {
        leaguesResponse = value;
        emit(LeaguesShow());
      } else {
        emit(LeaguesFail());
      }
    });
  }
}
