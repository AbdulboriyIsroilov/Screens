import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key, required this.title1, required this.title2, required this.svg,
  });
  final String title1,title2,svg;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 242.w,
        height: 180.h,
        child: Column(
          spacing: 12.h,
          children: [
            SvgPicture.asset(
              svg,
              width: 64.w,
              height: 64.h,
            ),
            Text(
              title1,
              style: theme.textTheme.labelLarge,
              textAlign: TextAlign.center,

            ),
            Text(
              title2,
              style: AppStyles.w400s16.copyWith(color: AppColors.greyBlack),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
