part of 'players_cubit.dart';

@immutable
abstract class PlayersState {}

class DataLoading extends PlayersState {}

class Failure extends PlayersState {}

class PlayersData extends PlayersState {
  final PlayersModel response;
  PlayersData({required this.response});
}
