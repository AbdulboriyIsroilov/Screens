import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';

class AccountRow extends StatelessWidget {
  const AccountRow({
    super.key,
    required this.svg,
    required this.title,
    this.onPressed = _defaultOnPressed,
  });

  final String svg, title;
  final VoidCallback onPressed;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 341.w,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: BoxBorder.all(color: AppColors.grey),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 16.w,
              children: [
                SvgPicture.asset(
                  svg,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(AppColors.black, BlendMode.modulate),
                ),
                Text(title, style: AppStyles.w400s16),
              ],
            ),
            SvgPicture.asset(AppSvgs.arrowRightChevron, width: 24.w, height: 24.h),
          ],
        ),
      ),
    );
  }
}
