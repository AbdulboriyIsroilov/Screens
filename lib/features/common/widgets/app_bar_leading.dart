import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_svg.dart';

class AppBarLeading extends StatelessWidget implements PreferredSizeWidget {
  const AppBarLeading({
    super.key,
    this.onPressed = _defaultPressed,
  });

  static void _defaultPressed() {}
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      leading: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(AppSvgs.backArrow),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56);
}
