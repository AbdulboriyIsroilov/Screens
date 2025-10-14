import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';

import '../../../core/l10n/app_localizations.dart';

/// 🗓 Tug‘ilgan sana tanlash uchun widget
class BirthDatePickerWidget extends StatelessWidget {
  final DateTime? tugilganSana;
  final Function() onSelectDate;

  const BirthDatePickerWidget({
    super.key,
    required this.tugilganSana,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = MyLocalizations.of(context)!;

    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(local.date_of_birth, style: theme.textTheme.bodyLarge),
        GestureDetector(
          onTap: onSelectDate,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tugilganSana == null
                      ? local.select_date
                      : "${tugilganSana!.day.toString().padLeft(2, '0')}/"
                            "${tugilganSana!.month.toString().padLeft(2, '0')}/"
                            "${tugilganSana!.year}",
                  style: theme.textTheme.bodyLarge,
                ),
                SvgPicture.asset(AppSvgs.calendar),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
