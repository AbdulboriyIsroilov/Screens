import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/app_svg.dart';

class TextFieldPasword extends StatefulWidget {
  const TextFieldPasword({
    super.key,
    required this.controller,
    required this.text,
    required this.hint,
    required this.validator,
    this.succes = false,
  });

  final TextEditingController controller;
  final String text, hint;
  final String? Function(String?) validator;
  final bool succes;

  @override
  State<TextFieldPasword> createState() => _TextFieldPaswordState();
}

class _TextFieldPaswordState extends State<TextFieldPasword> {
  bool passw = false;

  @override
  Widget build(BuildContext _context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: AppStyles.w500s16.copyWith(height: 0.3),
        ),
        TextFormField(
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.always,
          obscureText: passw,
          style: AppStyles.w500s16,
          controller: widget.controller,
          // keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            constraints: BoxConstraints(
              minWidth: 341.w,
              maxWidth: 341.w,
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
              borderSide: BorderSide(color: widget.succes ? AppColors.succes : AppColors.black),
            ),
            hintText: widget.hint,
            hintStyle: AppStyles.w400s16.copyWith(color: AppColors.black.withValues(alpha: 0.5)),
            suffixIcon: IconButton(
              onPressed: () {
                passw = !passw;
                setState(() {});
              },
              icon: widget.succes
                  ? passw
                        ? SvgPicture.asset(AppSvgs.eye)
                        : SvgPicture.asset(AppSvgs.eyeOff)
                  : SvgPicture.asset(AppSvgs.warningCircle),
            ),
          ),
        ),
      ],
    );
  }
}
