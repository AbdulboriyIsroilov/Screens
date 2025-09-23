import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/account/widgets/account_row.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/managers/localizatoin_cubit.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';

class AccountPages extends StatelessWidget {
  const AccountPages({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(title: local.account, activ: 4),
      body: Column(
        spacing: 15.h,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: AccountRow(svg: AppSvgs.box, title: local.my_orders),
          ),
          Container(
            width: double.infinity,
            height: 8.h,
            color: AppColors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Column(
              spacing: 15.h,
              children: [
                AccountRow(svg: AppSvgs.details, title: local.details),
                AccountRow(svg: AppSvgs.home, title: local.address_book),
                AccountRow(svg: AppSvgs.card, title: local.payment_methods),
                AccountRow(svg: AppSvgs.bell, title: local.notifications),
                AccountRow(
                  svg: AppSvgs.language,
                  title: local.language,
                  onPressed: () {
                    String tanlanganTil = context.read<LocalizationCubit>().locals == "uz"
                        ? "O‘zbekcha"
                        : context.read<LocalizationCubit>().locals == "ru"
                        ? "Русский"
                        : "English";
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              width: 390.w,
                              height: 350.h,
                              padding: EdgeInsets.fromLTRB(24.5.w, 30.h, 24.5.w, 31.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 15.h,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        local.switch_language,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: SvgPicture.asset(AppSvgs.cancel),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        spacing: 10.w,
                                        children: [
                                          SvgPicture.asset(AppSvgs.uz),
                                          Text("O`zbekcha", style: AppStyles.w600s16),
                                        ],
                                      ),
                                      Radio<String>(
                                        value: "O‘zbekcha",
                                        groupValue: tanlanganTil,
                                        onChanged: (value) {
                                          context.read<LocalizationCubit>().changeLocale(locale: "uz");
                                          setState(() {
                                            tanlanganTil = value.toString();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        spacing: 10.w,
                                        children: [
                                          SvgPicture.asset(AppSvgs.en),
                                          Text("English", style: AppStyles.w600s16),
                                        ],
                                      ),
                                      Radio<String>(
                                        value: "English",
                                        groupValue: tanlanganTil,
                                        onChanged: (value) {
                                          context.read<LocalizationCubit>().changeLocale(locale: "en");
                                          setState(() {
                                            tanlanganTil = value.toString();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        spacing: 10.w,
                                        children: [
                                          SvgPicture.asset(AppSvgs.ru),
                                          Text("Русский", style: AppStyles.w600s16),
                                        ],
                                      ),
                                      Radio<String>(
                                        value: "Русский",
                                        groupValue: tanlanganTil,
                                        onChanged: (value) {
                                          context.read<LocalizationCubit>().changeLocale(locale: "ru");
                                          setState(() {
                                            tanlanganTil = value.toString();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 8.h,
            color: AppColors.grey,
          ),
          AccountRow(svg: AppSvgs.question, title: local.f_a_qs),
          AccountRow(svg: AppSvgs.headphones, title: local.help_center),
          Container(
            width: double.infinity,
            height: 8.h,
            color: AppColors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 34.w, right: 24.w),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.go(Routers.login);
              },
              child: Row(
                spacing: 19.w,
                children: [
                  SvgPicture.asset(AppSvgs.logout, width: 19.w, height: 19.h),
                  Text(local.logout, style: AppStyles.w400s16.copyWith(color: Colors.red)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 4),
    );
  }
}
