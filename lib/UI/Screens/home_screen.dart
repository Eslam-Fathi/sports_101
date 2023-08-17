import 'package:flutter/material.dart';
import 'package:sports_101/Shared/shared_dialog.dart';
import 'package:sports_101/UI/Screens/countryscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/shared_container_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GridView.count(
            childAspectRatio: 1 / 2,
            crossAxisCount: 2, // Number of columns
            mainAxisSpacing: 10.h, // Spacing between rows
            crossAxisSpacing: 10.w, // Spacing between columns
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 10 / 392.7,
                vertical: MediaQuery.of(context).size.height *
                    50 /
                    872.7), // Padding around the grid
            children: [
              SharedContainer(
                catoname: "Football",
                imagetext: "assets/Images/Football.png",
                ontapfunction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CountryScreen(),
                    ),
                  );
                },
              ),
              SharedContainer(
                catoname: "BasketBall",
                imagetext: "assets/Images/Basketball.png",
                ontapfunction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SharedAlertDialog(
                        titletext: "Basketball",
                        contenttext: "Coming soon",
                        dialogontap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
              SharedContainer(
                catoname: "Volleyball",
                imagetext: "assets/Images/Volleyball.png",
                ontapfunction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SharedAlertDialog(
                        titletext: "Volleyball",
                        contenttext: "Coming soon",
                        dialogontap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
              SharedContainer(
                catoname: "Tennis",
                imagetext: "assets/Images/Tennis.png",
                ontapfunction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SharedAlertDialog(
                        titletext: "Tennis",
                        contenttext: "Coming soon",
                        dialogontap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ]),
      ),
    );
  }
}
