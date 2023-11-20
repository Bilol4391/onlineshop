import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyProducts extends StatelessWidget {
  const EmptyProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        150.r.verticalSpace,
        Text(
          'No Products',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        10.r.verticalSpace,
        Image.asset(
          "assets/icons/box.png",
          fit: BoxFit.cover,
          height: 70.h,
        ),
      ],
    );
  }
}