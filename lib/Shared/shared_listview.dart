import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Data/Cubits/Top_Scorers_Cubit/top_scorers_cubit.dart';

class SharedListView extends StatelessWidget {
  const SharedListView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopScorersCubit, TopScorersState>(
      builder: (context, state) {
        if (state is TopScorersInitial) {
          return const SizedBox();
        } else if (state is TopScorersLoading) {
          return const CircularProgressIndicator();
        } else if (state is TopScorersShow) {
          return Expanded(
            child: ListView.separated(
              itemCount: state.scorerResponse.topScorers.length,
              separatorBuilder: (context, index) => const Divider(
                endIndent: 30.0,
                indent: 30.0,
                color: Colors.white70,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        state.scorerResponse.topScorers[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "goals: ${(state.scorerResponse.topScorers[index].goals)}",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 18.sp,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text(
              "No Data Found",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
