import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Cubits/Teams_Cubit/teams_cubit.dart';
import '../../Data/Cubits/Top_Scorers_Cubit/top_scorers_cubit.dart';
import '../../Shared/shared_gridview.dart';
import '../../Shared/shared_listview.dart';

class TeamsTabBar extends StatefulWidget {
  final int? leagueId;
  const TeamsTabBar({super.key, this.leagueId});

  @override
  State<TeamsTabBar> createState() => _TeamsTabBarState();
}

class _TeamsTabBarState extends State<TeamsTabBar> {
  // final TextEditingController _searchteams = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<TeamsCubit>().getAllTeams(widget.leagueId!, "");
      context.read<TopScorersCubit>().getTopScorers(widget.leagueId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Color(0xFF1D1C21)),
                child: const TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.sports_soccer_outlined,
                        color: Colors.white,
                      ),
                      child: Text(
                        "Teams",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      child: Text(
                        "Top Scorers",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: TabBarView(
                    children: <Widget>[
                      SharedGridView(leagueid: widget.leagueId),
                      const SharedListView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}













/*
DataRowPlayer(PlayerKey: state.scorerRsponse.result?[index].playerName
                              .toString() ??
                          "No Player\n",, PlayerValue: "goals: ${state.scorerRsponse.result?[index].goals.toString()}",)
                



                leading: DataRowPlayer(
                    PlayerKey: state.scorerRsponse.result?[index].playerName
                            .toString() ??
                        "No Player\n",
                    PlayerValue:
                        "goals: ${state.scorerRsponse.result?[index].goals.toString()}",
                  ),


 */
