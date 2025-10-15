import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCenterButton extends StatelessWidget {
  const HelpCenterButton({
    super.key,
    required this.svg,
    required this.title,
    this.onPressed = _defaultOnPressed,
  });

  final String svg, title;
  final VoidCallback? onPressed;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 341.w,
        height: 52.h,
        decoration: BoxDecoration(
          border: BoxBorder.all(color: theme.colorScheme.inversePrimary,width: 1.5),
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
      ),
    );
  }
}
