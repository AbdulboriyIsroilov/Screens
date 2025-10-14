import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';

class HelpCenterButton extends StatelessWidget {
  const HelpCenterButton({
    super.key,
    required this.svg,
    required this.title,
  });

  final String svg, title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 341.w,
      height: 52.h,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: theme.colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Row(
        spacing: 12.w,
        children: [
          SvgPicture.asset(
            svg,
            colorFilter: ColorFilter.mode(theme.colorScheme.onPrimaryFixed, BlendMode.srcIn),
          ),
          Text(title, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
