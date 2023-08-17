part of 'top_scorers_cubit.dart';

abstract class TopScorersState {}

class TopScorersInitial extends TopScorersState {}

class TopScorersShow extends TopScorersState {
  final TopScorersModel scorerResponse;
  TopScorersShow({required this.scorerResponse});
}

class TopScorersLoading extends TopScorersState {}

class TopScorersFail extends TopScorersState {}
