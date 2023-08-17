import 'package:bloc/bloc.dart';
import 'package:sports_101/Data/Models/Teams_model/result.dart';

import '../../Models/Teams_model/teams_model.dart';
import '../../Repositories/teams_repo.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(TeamsInitial());
  Future<void> getAllTeams(int leagueId, String searchQuery) async {
    emit(TeamsLoading());
    try {
      final teamResponse =
          await LeagueTeamsRepo().getAllTeams(leagueId, searchQuery);
      if (teamResponse!.result != null) {
        final filteredTeams = teamResponse.result!
            .where((team) => team.teamName!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
        emit(TeamShow(teamResponse: teamResponse, teams: filteredTeams));
      } else {
        emit(TeamsFail());
      }
    } catch (e) {
      emit(TeamsFail());
    }
  }
}
