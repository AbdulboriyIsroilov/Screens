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
    required this.title,
    required this.hint,
    required this.validator,
    this.succes = false,
    this.keyboard = TextInputType.text,
  });

  final TextEditingController controller;
  final String title, hint;
  final String? Function(String?) validator;
  final bool succes;
  final TextInputType keyboard;

  @override
  State<TextFieldPasword> createState() => _TextFieldPaswordState();
}

class _TextFieldPaswordState extends State<TextFieldPasword> {
  bool passw = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.bodyLarge,
        ),
        TextFormField(
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.always,
          obscureText: passw,
          style: theme.textTheme.bodyLarge,
          controller: widget.controller,
          keyboardType: widget.keyboard,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            constraints: BoxConstraints(
              minWidth: 341.w,
              maxWidth: 341.w,
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
              borderSide: BorderSide(color: widget.succes ? AppColors.succes : AppColors.black,width: 1.5),
            ),
            hintText: widget.hint,
            hintStyle: AppStyles.w400s16.copyWith(color: AppColors.grey),
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
