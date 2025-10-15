import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routes.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/account/widgets/account_row.dart';
import 'package:screens/features/account/widgets/show_dialog_logout.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/managers/app_theme_cubit.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../widgets/language_bottom_sheet.dart';

class AccountPages extends StatelessWidget {
  const AccountPages({super.key});

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarCommon(
        title: local.account,
        activ: 4,
        onPressed: () {
          context.go(Routes.home);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 7.h,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
              child: AccountRow(
                svg: AppSvgs.box,
                title: local.my_orders,
                onPressed: () => context.push(Routes.myOrders),
              ),
            ),

            Container(width: double.infinity, height: 8.h, color: theme.colorScheme.inversePrimary),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
              child: Column(
                spacing: 15.h,
                children: [
                  AccountRow(
                    svg: AppSvgs.details,
                    title: local.my_details,
                    onPressed: () => context.push(Routes.myDetail),
                  ),
                  AccountRow(
                    svg: AppSvgs.home,
                    title: local.address_book,
                    onPressed: () => context.push(Routes.address),
                  ),
                  AccountRow(
                    svg: AppSvgs.card,
                    title: local.payment_methods,
                    onPressed: () => context.push(Routes.card),
                  ),
                  AccountRow(
                    svg: AppSvgs.bell,
                    title: local.notifications,
                    onPressed: () => context.push(Routes.notificationSettings),
                  ),
                  AccountRow(
                    svg: AppSvgs.language,
                    title: local.language,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                        ),
                        builder: (context) => LanguageBottomSheet(local: local),
                      );
                    },
                  ),
                  AccountRow(
                    svg: context.watch<AppThemeCubit>().state == ThemeMode.dark ? AppSvgs.sun : AppSvgs.moon,
                    title: context.watch<AppThemeCubit>().state == ThemeMode.dark
                        ? "Turn light Theme"
                        : "Turn dark Theme",
                    onPressed: () {
                      context.read<AppThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
            ),

            Container(width: double.infinity, height: 8.h, color: theme.colorScheme.inversePrimary),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
              child: Column(
                spacing: 15.h,
                children: [
                  AccountRow(
                    svg: AppSvgs.question,
                    title: local.f_a_qs,
                    onPressed: () => context.push(Routes.faq),
                  ),
                  AccountRow(
                    svg: AppSvgs.headphones,
                    title: local.help_center,
                    onPressed: () => context.push(Routes.helpCenter),
                  ),
                ],
              ),
            ),

            Container(width: double.infinity, height: 8.h, color: theme.colorScheme.inversePrimary),

            Padding(
              padding: EdgeInsets.only(left: 34.w, right: 24.w, bottom: 24.h, top: 15.h),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ShowDialogLogout(),
                  );
                },
                child: Row(
                  spacing: 19.w,
                  children: [
                    SvgPicture.asset(AppSvgs.logout, width: 19.w, height: 19.h),
                    Text(
                      local.logout,
                      style: AppStyles.w400s16.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarMain(isActive: 4),
    );
  }
}
