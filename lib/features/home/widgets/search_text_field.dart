import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.maxWidth = 281,
    required this.search,
  });

  final TextEditingController controller;
  final double maxWidth;
  final String search;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppStyles.w500s16,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        constraints: BoxConstraints(
          minWidth: 280.w,
          maxWidth: maxWidth.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        hintText: search,
        hintStyle: AppStyles.w400s16.copyWith(
          color: AppColors.black.withValues(alpha: 0.5),
        ),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppSvgs.search),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppSvgs.mic),
        ),
      ),
    );
  }
}
