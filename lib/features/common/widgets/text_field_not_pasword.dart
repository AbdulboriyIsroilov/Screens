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
    final ThemeData theme = Theme.of(context);
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge,
        ),
        TextFormField(
          validator: validator,
          inputFormatters: formatter,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: keyboard,
          controller: controller,
          style: theme.textTheme.bodyLarge,
          maxLines: maxLine,
          cursorColor: theme.colorScheme.onPrimaryFixed,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            constraints: BoxConstraints(
              minWidth: 150.w,
              maxWidth: maxwidth.w,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.error,width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.grey,width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.error,width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: succes ? AppColors.succes : theme.colorScheme.onPrimaryFixed,width: 1.5),
            ),
            hintText: hint,
            hintStyle: AppStyles.w400s16.copyWith(color: AppColors.grey),
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
