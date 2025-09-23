import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';

class MyCartButton extends StatelessWidget {
  const MyCartButton({
    super.key,
    this.onPressed = _defaultOnPressed,
    required this.svg,
  });

  final VoidCallback onPressed;
  final String svg;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 23.5.w,
        height: 23.5.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          border: BoxBorder.all(color: AppColors.grey),
        ),
        padding: EdgeInsets.all(3),
        child: SvgPicture.asset(svg),
      ),
    );
  }
}
