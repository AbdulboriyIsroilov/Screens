import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/app_svg.dart';
import '../../../core/l10n/app_localizations.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;
  final bool isScrolling;
  final Function(String) onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.theme,
    required this.isScrolling,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isScrolling ? 100 : 0,
          sigmaY: isScrolling ? 100 : 0,
        ),
        child: Container(
          color: isScrolling ? Colors.black.withOpacity(0.05) : Colors.black.withOpacity(0.08),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.w, 5.h, 25.w, 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: theme.textTheme.bodyLarge,
                      cursorColor: theme.colorScheme.onPrimaryFixed,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                        hintText: local.write_your_message,
                        hintStyle: AppStyles.w400s16.copyWith(color: AppColors.greyDark),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: theme.colorScheme.inverseSurface, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: theme.colorScheme.inverseSurface, width: 1.5),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppSvgs.image),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Ink(
                    decoration: ShapeDecoration(
                      color: theme.colorScheme.onInverseSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        fixedSize: Size(52.w, 52.h),
                      ),
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          onSend(controller.text.trim());
                          controller.clear();
                        }
                      },
                      icon: SvgPicture.asset(
                        AppSvgs.send,
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
