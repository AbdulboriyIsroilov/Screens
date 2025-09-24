import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/l10n/app_localizations.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';

class Diolog extends StatelessWidget {
  const Diolog({
    super.key,
    required this.local,
  });

  final MyLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 78.5.w,
              height: 78.5.h,
              child: SvgPicture.asset(AppSvgs.correct),
            ),
            Text(
              local.the_product_been_added_the_cart,
              style: AppStyles.w600s20,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
