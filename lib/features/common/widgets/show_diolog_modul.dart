import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';

import '../../../core/utils/app_style.dart';
import 'text_button_popular.dart';

class ShowDiologModul extends StatelessWidget {
  const ShowDiologModul({
    super.key,
    required this.title1,
    required this.title2,
    required this.titleButton,
    this.onPressed = _defaultOnPressed,
  });

  final String title1, title2, titleButton;
  final VoidCallback onPressed;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Container(
        width: 341.w,
        height: 292.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixed,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.all(24.w),
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 78.5.w,
                height: 78.5.h,
                child: SvgPicture.asset(AppSvgs.correct),
              ),
              Text(
                title1,
                style: theme.textTheme.labelLarge,
              ),
              Text(
                title2,
                style: AppStyles.w400s16.copyWith(color: AppColors.textGrey),
                textAlign: TextAlign.center,
              ),
              TextButtonPopular(
                title: titleButton,
                width: 293,
                height: 54,
                style: AppStyles.w500s16w,
                color: theme.colorScheme.onInverseSurface,
                border: false,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
