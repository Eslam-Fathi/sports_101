import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Boarding extends StatelessWidget {
  final Color backgroundColor;
  final String imagePass;
  final String title;
  final double uniSize;

  const Boarding({
    required this.uniSize,
    required this.backgroundColor,
    required this.imagePass,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: Column(
        children: [
          Expanded(
              flex: 6,
              child: Center(
                child: Image.asset(
                  imagePass,
                  height: MediaQuery.of(context).size.height * uniSize.h,
                  width: MediaQuery.of(context).size.width * uniSize.w,
                ),
              )),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            flex: 3,
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Georgia",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
