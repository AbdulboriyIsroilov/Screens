import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';

import '../../../core/utils/app_style.dart';
import '../../../core/utils/app_svg.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCommon({
    super.key,
    required this.title,
    this.onPressed = _defaultPressed,
    this.action = true,
    required this.activ,
  });

  static void _defaultPressed() {}

  final String title;
  final VoidCallback onPressed;
  final bool action;
  final int activ;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leadingWidth: 75,
      leading: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(AppSvgs.backArrow),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: AppStyles.w600s25,
      ),
      actions: action
          ? [
              IconButton(
                onPressed: () {
                  context.push(Routers.notifications, extra: {"index": activ});
                },
                icon: SvgPicture.asset(AppSvgs.bell),
              ),
              SizedBox(width: 25.w),
            ]
          : [],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Divider(
            color: AppColors.grey,
            height: 1,
            thickness: 1,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56.h);
}
