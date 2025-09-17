import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_style.dart';

import '../../../core/router/routers.dart';
import '../../../core/utils/app_colors.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.id,
  });

  final int id;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          Routers.home,
          extra: {
            "categoryId": id,
          },
        );
      },
      child: Container(
              height: 36.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: BoxBorder.all(color: isSelected ? AppColors.black : AppColors.grey),
              ),
              child: Text(
                title,
                style: AppStyles.w500s16.copyWith(
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ),
    );
  }
}
