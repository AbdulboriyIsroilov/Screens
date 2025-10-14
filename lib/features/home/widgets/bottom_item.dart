import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/home/managers/home_bloc.dart';
import 'package:screens/features/home/managers/home_event.dart';

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
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.read<HomeBloc>().add(FetchProductsEvent(categoryId: id));
      },
      child: Container(
        height: 36.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.onInverseSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: BoxBorder.all(color: isSelected ? AppColors.black : theme.colorScheme.inversePrimary,width: 1.5),
        ),
        child: Text(
          title,
          style: AppStyles.w500s16.copyWith(
            color: isSelected ? AppColors.white : theme.colorScheme.onPrimaryFixed,
          ),
        ),
      ),
    );
  }
}
