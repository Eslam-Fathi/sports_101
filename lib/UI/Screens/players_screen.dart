import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Data/Cubits/PlayersCubit/players_cubit.dart';
import '../../Shared/shared_player_dialog.dart';

class PlayerScreen extends StatefulWidget {
  final int teamid;

  const PlayerScreen({super.key, required this.teamid});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final TextEditingController _playersearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PlayersCubit>().getPlayersData(widget.teamid, "r");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      bottom: true,
      right: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              color: const Color(0xFF1D1C21),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                              'assets/Images/carbon_chevron-left.svg',
                              width: 32.w,
                              height: 32.h),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: TextField(
                          onSubmitted: (value) {
                            context.read<PlayersCubit>().getPlayersData(
                                widget.teamid, _playersearch.text);
                          },
                          style: const TextStyle(color: Colors.white60),
                          controller: _playersearch,
                          decoration: InputDecoration(
                            labelText: 'Search player',
                            labelStyle: const TextStyle(color: Colors.white60),
                            prefixIcon: InkWell(
                              child: const Icon(
                                Icons.search,
                                color: Colors.white60,
                              ),
                              onTap: () => context
                                  .read<PlayersCubit>()
                                  .getPlayersData(
                                      widget.teamid, _playersearch.text),
                            ),
                            fillColor: const Color(0xFF2F2F31),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 10.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'PLAYER',
                            style: GoogleFonts.bebasNeue(
                              textStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      100 /
                                      375,
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.1),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5.sp,
                                  overflow: TextOverflow.visible),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 29.h, horizontal: 20.w),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.bebasNeue(
                              textStyle: TextStyle(
                                  fontSize: 23.sp,
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.8),
                                  wordSpacing: 1.5.sp),
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Follow your\nfavorite players\n",
                              ),
                              TextSpan(
                                text: "\nGet news,game updates highlights and "
                                    "more\n"
                                    "info on your favorite teams",
                                style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            15 /
                                            812,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<PlayersCubit, PlayersState>(
                builder: (context, state) {
                  if (state is DataLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      color: Colors.blue,
                    ));
                  } else if (state is PlayersData) {
                    return ListView.builder(
                      itemCount: state.response.result.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.8,
                                  child: SimpleDialog(
                                    titlePadding: const EdgeInsets.only(
                                        left: 5,
                                        right: 30,
                                        top: 15,
                                        bottom: 15),
                                    backgroundColor: const Color(0xFF1D1C21),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: SvgPicture.asset(
                                                'assets/Images/carbon_chevron-left.svg',
                                                width: 29,
                                                height: 29,
                                                alignment: Alignment.topLeft),
                                          ),
                                        ),
                                        CircleAvatar(
                                          child: Image.network(
                                            state.response.result[index]
                                                .playerImage
                                                .toString(),
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              // Return your custom error widget here
                                              return Image.asset(
                                                  "assets/Images/playeravatar.png");
                                            },
                                          ),
                                        ),
                                        Text(
                                          state.response.result[index]
                                                  .playerName ??
                                              'Not Specified',
                                          textScaleFactor: 0.8,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    children: <Widget>[
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player number',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerNumber ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player country',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerCountry ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player position',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerType ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player age',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerAge ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey:
                                                  'Player yellow cards num',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerYellowCards ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player red cards num',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerRedCards ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player goals',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerGoals ??
                                                  'Not Specified')),
                                      const SimpleDialogOption(
                                        child: Divider(
                                          height: 1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      SimpleDialogOption(
                                          child: DataRowPlayer(
                                              PlayerKey: 'Player assists',
                                              PlayerValue: state
                                                      .response
                                                      .result[index]
                                                      .playerAssists ??
                                                  'Not Specified')),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          leading: CircleAvatar(
                            child: Image.network(
                              state.response.result[index].playerImage
                                  .toString(),
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                // Return your custom error widget here
                                return Image.asset(
                                    "assets/Images/playeravatar.png");
                              },
                            ),
                          ),
                          title: Text(
                            state.response.result[index].playerName ??
                                'Not Specified',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                          subtitle: Text(
                            state.response.result[index].playerType ??
                                'Not Specified',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xFFFFFFFF).withOpacity(0.8),
                            wordSpacing: 1.5),
                      ),
                    );

                    //showNetworkAlertDialog(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
