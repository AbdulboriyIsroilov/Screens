import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';

class TextButtonPopular extends StatelessWidget {
  const TextButtonPopular({
    super.key,
    this.onPressed = _defaultOnPressed,
    this.width = 341,
    this.height = 54,
    required this.title,
    this.color = AppColors.black,
    this.style = AppStyles.w500s16w,
    this.border = true,
  });

  final VoidCallback? onPressed;
  final int width, height;
  final String title;
  final Color color;
  final TextStyle style;
  final bool border;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: AppColors.grey,
        fixedSize: Size(width.w, height.h),
        side: border
            ? const BorderSide(color: AppColors.greyDark, width: 2)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
