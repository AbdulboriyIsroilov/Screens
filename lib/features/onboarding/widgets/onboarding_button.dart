import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key, this.onPressed = _defaultOnPressed,
  });
  final VoidCallback onPressed;
  static void _defaultOnPressed() {}
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.black,
        fixedSize: Size(341.w, 54.h),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.w,
        children: [
          Text(
            "Get Started",
            style: AppStyles.w500s16w,
          ),
          SvgPicture.asset(AppSvgs.arrowRight),
        ],
      ),
    );
  }
}
