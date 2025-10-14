import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screens/core/utils/app_colors.dart';

import '../../../core/l10n/app_localizations.dart';

class GenderDropdownWidget extends StatelessWidget {
  final String? gender;
  final Function(String?) onChanged;

  const GenderDropdownWidget({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = MyLocalizations.of(context)!;

    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(local.gender, style: theme.textTheme.bodyLarge),
        DropdownButtonFormField<String>(
          value: gender,
          hint: Text(local.select_gender),
          items: ["Male", "Female"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 14.sp)),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.grey, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
