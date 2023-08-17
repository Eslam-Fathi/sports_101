import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/Players/players_model.dart';
import '../../Repositories/players_repo.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit() : super(DataLoading());
  getPlayersData(int teamid, String playername) async {
    emit(DataLoading());
    PlayersRepo().getPlayersData(teamid, playername).then((value) => {
          if (value != null)
            {emit(PlayersData(response: value))}
          else
            {
              emit(Failure()),
            }
        });
  }
}
