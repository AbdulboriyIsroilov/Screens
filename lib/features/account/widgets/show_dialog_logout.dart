import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';

import '../../../core/l10n/app_localizations.dart';

class ShowDialogLogout extends StatelessWidget {
  const ShowDialogLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Center(
      child: Container(
        width: 341.w,
        height: 336.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.white,
        ),
        padding: EdgeInsets.all(24),
        child: Material(
          child: Column(
            spacing: 24.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: 8.h,
                children: [
                  SvgPicture.asset(
                    AppSvgs.warning,
                    width: 78.5.w,
                    height: 78.5.h,
                  ),
                  Text("${local.logout}?", style: AppStyles.w600s20),
                  Text(
                    local.are_you_sure_you_want_logout,
                    style: AppStyles.w400s16,
                  ),
                ],
              ),
              Column(
                spacing: 12.h,
                children: [
                  TextButtonPopular(
                    title: local.yes_logout,
                    color: AppColors.error,
                    width: 293,
                    border: false,
                    onPressed: () {
                      context.go(Routers.login);
                    },
                  ),
                  TextButtonPopular(
                    title: local.no_cancel,
                    color: AppColors.white,
                    style: AppStyles.w500s16,
                    width: 293,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
