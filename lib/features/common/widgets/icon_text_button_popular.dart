import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';

class IconTextButtonPopular extends StatelessWidget {
  const IconTextButtonPopular({
    super.key,
    this.onPressed = _defaultOnPressed,
    this.width = 341,
    this.height = 54,
    required this.icon,
    required this.title,
    this.color = AppColors.black,
    this.fColor = AppColors.white,
  });

  final VoidCallback? onPressed;
  final int width, height;
  final String icon, title;
  final Color color, fColor;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: AppColors.grey,
        fixedSize: Size(width.w, height.h),
        side: BorderSide(color: AppColors.grey, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: onPressed,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.w,
        children: [
          SvgPicture.asset(icon,width: 24.w,height: 24.h,),
          Text(
            title,
            style: AppStyles.w500s16.copyWith(color: fColor),
          ),
        ],
      ),
    );
  }
}
