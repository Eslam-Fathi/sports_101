import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_101/Data/Cubits/LeaguesCubit/leagues_cubit.dart';
import 'package:sports_101/Shared/shared_appbar.dart';
import 'package:sports_101/UI/Screens/teams_screen.dart';

class LeagueScreen extends StatefulWidget {
  final int countryid;
  const LeagueScreen({super.key, required this.countryid});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaguesCubit>().getLeagues(widget.countryid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const SharedAppBar(titleName: "Leagues"),
        backgroundColor: Colors.black,
        body: BlocBuilder<LeaguesCubit, LeaguesState>(
          buildWhen: (previous, current) {
            if (current is LeaguesShow) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            final cubit = context.watch<LeaguesCubit>();
            if (cubit.leaguesResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (cubit.leaguesResponse!.success == 0) {
              return const Center(
                child: Text("Error"),
              );
            }
            return ListView.builder(
              itemCount: cubit.leaguesResponse!.leagues.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamsTabBar(
                            leagueId: cubit
                                .leaguesResponse!.leagues[index].leagueKey),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height * 1 / 8,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text:
                                  "${cubit.leaguesResponse!.leagues[index].leagueName}\n\n",
                              style: GoogleFonts.abel(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: cubit.leaguesResponse!.leagues[index]
                                      .countryName,
                                  style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 60,
                          height: 70,
                          child: CachedNetworkImage(
                            imageUrl: cubit.leaguesResponse!.leagues[index]
                                    .leagueLogo ??
                                "https://apiv2.allsportsapi.com/logo/10464_karnataka.jpg",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.sports_soccer_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
