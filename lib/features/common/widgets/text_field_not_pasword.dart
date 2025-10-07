import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/app_svg.dart';

class TextFieldNotPasword extends StatelessWidget {
  const TextFieldNotPasword({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.maxLine = 1,
    this.validator,
    this.succes = false,
    this.maxwidth = 341,
    this.formatter = const [],
    this.keyboard = TextInputType.text,
    this.suffixicon = false,
  });

  final TextEditingController controller;
  final String title, hint;
  final int maxLine, maxwidth;
  final String? Function(String?)? validator;
  final bool succes, suffixicon;
  final List<TextInputFormatter> formatter;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.w500s16.copyWith(height: 0.3),
        ),
        TextFormField(
          validator: validator,
          inputFormatters: formatter,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: keyboard,
          controller: controller,
          style: AppStyles.w500s16,
          maxLines: maxLine,
          cursorColor: AppColors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            constraints: BoxConstraints(
              minWidth: 150.w,
              maxWidth: maxwidth.w,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.error),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: succes ? AppColors.succes : AppColors.black),
            ),
            hintText: hint,
            hintStyle: AppStyles.w400s16.copyWith(color: AppColors.black.withValues(alpha: 0.5)),
            suffixIcon: suffixicon
                ? null
                : IconButton(
                    onPressed: () {},
                    icon: succes ? SvgPicture.asset(AppSvgs.correct) : SvgPicture.asset(AppSvgs.warningCircle),
                  ),
          ),
        ),
      ],
    );
  }
}
