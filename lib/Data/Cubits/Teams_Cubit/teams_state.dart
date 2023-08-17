part of 'teams_cubit.dart';

abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class TeamShow extends TeamsState {
  final TeamsModel teamResponse;
  final List<Result> teams;

  TeamShow({required this.teamResponse, required this.teams});
}

class TeamsLoading extends TeamsState {}

class TeamsFail extends TeamsState {}
