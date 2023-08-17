import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleName;
  final TabBar? tabBarr;
  const SharedAppBar({super.key, required this.titleName, this.tabBarr});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: tabBarr,
      backgroundColor: const Color(0xFF1D1C21),
      leadingWidth: 35.w,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: SvgPicture.asset('assets/Images/carbon_chevron-left.svg',
            width: 15.w, height: 15.h),
      ),
      title: Align(
          alignment: const Alignment(-0.15, 0),
          child: Text(
            titleName,
            style: GoogleFonts.bebasNeue(
              letterSpacing: 1.sp,
              fontSize: 34.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300,
              shadows: [Shadow(blurRadius: 50.r)],
            ),
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
