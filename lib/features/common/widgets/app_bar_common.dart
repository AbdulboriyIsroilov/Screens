import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';

import '../../../core/utils/app_svg.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCommon({
    super.key,
    required this.title,
    this.onPressed,
    this.action = true,
    required this.activ,
    this.bottom,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool action;
  final int activ;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leadingWidth: 75,
      leading: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            AppSvgs.backArrow,
            colorFilter: ColorFilter.mode(theme.colorScheme.onPrimaryFixed, BlendMode.srcIn),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(title, style: theme.textTheme.labelMedium),
      actions: action
          ? [
              IconButton(
                onPressed: () {
                  context.push(Routers.notifications, extra: {"index": activ});
                },
                icon: SvgPicture.asset(
                  AppSvgs.bell,
                  colorFilter: ColorFilter.mode(theme.colorScheme.onPrimaryFixed, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 25.w),
            ]
          : [],
      bottom:
          bottom ??
          PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Divider(
                color: theme.colorScheme.inversePrimary,
                height: 1,
                thickness: 1,
              ),
            ),
          ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56.h + (bottom?.preferredSize.height ?? 1));
}
