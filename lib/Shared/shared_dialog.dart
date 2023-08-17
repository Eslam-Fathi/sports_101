import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedAlertDialog extends StatelessWidget {
  final String? titletext;
  final String contenttext;
  final Function()? dialogontap;

  const SharedAlertDialog(
      {super.key, this.titletext, required this.contenttext, this.dialogontap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 15,
      shadowColor: Colors.black,
      backgroundColor: const Color(0xFF1D1C21),
      title: Text(
        titletext!,
        style: TextStyle(
          color: const Color(0xFFFFFFFF).withOpacity(0.8),
          fontSize: 22.sp,
        ),
      ),
      content: Text(
        contenttext,
        style: TextStyle(
          color: const Color(0xFFFFFFFF).withOpacity(0.8),
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.grey),
          ),
          onPressed: dialogontap,
          child: Text(
            "OK",
            style: TextStyle(
              color: const Color(0xFFFFFFFF).withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
/*

      backgroundColor: const Color(0xffB1B1B1).withOpacity(0.85),
      backgroundColor: Color.fromARGB(255, 71, 70, 76).withOpacity(0.95),

      backgroundColor: const Color(0xff343338).withOpacity(0.95),
      backgroundColor: const Color(0xff1D1C21).withOpacity(0.95),



 */