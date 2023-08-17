import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_101/Shared/shared_appbar.dart';
import 'package:sports_101/UI/Screens/league_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Data/Cubits/CountryCubit/country_with_cubit.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CountryWithCubit>().getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const SharedAppBar(titleName: "Countries"),
        backgroundColor: Colors.black,
        body: BlocBuilder<CountryWithCubit, CountryWithState>(
          buildWhen: (previous, current) {
            if (current is CountrySuccess) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            final cubit = context.watch<CountryWithCubit>();
            if (cubit.countryResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (cubit.countryResponse!.success == 0) {
              return const Center(
                child: Text("Error"),
              );
            }
            return GridView.count(
              childAspectRatio: 1,
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 5.0, // Spacing between rows
              crossAxisSpacing: 5.0, // Spacing between columns
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 10.h), // Padding around the grid
              children: List.generate(
                cubit.countryResponse!.result.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeagueScreen(
                            countryid:
                                cubit.countryResponse!.result[index].countryKey,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 120 / 392.7,
                            height: MediaQuery.of(context).size.height *
                                120 /
                                781.1,
                            child: CachedNetworkImage(
                              imageUrl: cubit.countryResponse!.result[index]
                                      .countryLogo ??
                                  "https://apiv2.allsportsapi.com/logo/10464_karnataka.jpg",
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              cubit.countryResponse!.result[index].countryName
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.bebasNeue(
                                letterSpacing: 1.sp,
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}



/*SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 70 / 392.7,
                            height:
                                MediaQuery.of(context).size.height * 70 / 781.1,
                            child: Image.network(
                              state.leaguesresponse.result[index].leagueLogo
                                  .toString(),
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                // Return your custom error widget here
                                return Image.network(
                                    "https://apiv2.allsportsapi.com/logo/10464_karnataka.jpg");
                              },
                            ),
                          ),*/
