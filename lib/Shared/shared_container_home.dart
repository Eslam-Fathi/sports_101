import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedContainer extends StatelessWidget {
  final String catoname;
  final String imagetext;
  final Function() ontapfunction;

  const SharedContainer(
      {super.key,
      required this.catoname,
      required this.imagetext,
      required this.ontapfunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapfunction,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          // color: Colors.white,
          image:
              DecorationImage(fit: BoxFit.cover, image: AssetImage(imagetext)),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            catoname,
            style: GoogleFonts.bebasNeue(
              letterSpacing: 1.sp,
              fontSize: 35.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              shadows: [Shadow(blurRadius: 100.r)],
            ),
          ),
        ),
      ),
    );
  }
}
