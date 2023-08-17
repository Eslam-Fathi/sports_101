import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_101/Data/Cubits/CountryCubit/country_with_cubit.dart';
import 'package:sports_101/Data/Cubits/LeaguesCubit/leagues_cubit.dart';
import 'package:sports_101/Data/Cubits/PlayersCubit/players_cubit.dart';
import 'package:sports_101/Data/Cubits/Teams_Cubit/teams_cubit.dart';
import 'package:sports_101/Data/Cubits/Top_Scorers_Cubit/top_scorers_cubit.dart';
import 'package:sports_101/UI/Screens/board_screen.dart';
import 'package:sports_101/UI/Screens/home_screen.dart';
import 'package:sports_101/UI/Screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'Global/global.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(Sports101(showHome: showHome));
}

class Sports101 extends StatelessWidget {
  final bool showHome;
  const Sports101({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaguesCubit>(
          create: (context) => LeaguesCubit(),
        ),
        BlocProvider<CountryWithCubit>(
          create: (context) => CountryWithCubit(),
        ),
        BlocProvider<PlayersCubit>(
          create: (context) => PlayersCubit(),
        ),
        BlocProvider<TeamsCubit>(
          create: (context) => TeamsCubit(),
        ),
        BlocProvider<TopScorersCubit>(
          create: (context) => TopScorersCubit(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          theme: ThemeData(primarySwatch: Colors.grey),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(showHome3: showHome),
        ),
        designSize: const Size(392.7, 872.7),
      ),
    );
  }
}
