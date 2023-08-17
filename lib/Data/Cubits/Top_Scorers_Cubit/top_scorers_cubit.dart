import 'package:bloc/bloc.dart';

import '../../Models/Top_Scorers_model/top_scorers_model/top_scorers_model.dart';
import '../../Repositories/top_scorers_repo.dart';

part 'top_scorers_state.dart';

class TopScorersCubit extends Cubit<TopScorersState> {
  TopScorersCubit() : super(TopScorersInitial());

  Future<void> getTopScorers(int leagueId) async {
    emit(TopScorersLoading());

    TopScorersRepo().getTopScorers(leagueId).then((value) {
      if (value != null) {
        emit(TopScorersShow(scorerResponse: value));
      } else {
        emit(TopScorersFail());
      }
    });
  }
}
