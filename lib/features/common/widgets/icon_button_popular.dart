import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/managers/like_cubit.dart';

import '../../../core/utils/app_colors.dart';

class IconButtonPopular extends StatefulWidget {
  const IconButtonPopular({
    super.key,
    required this.isLike,
    required this.id,
  });

  final bool isLike;
  final int id;

  @override
  State<IconButtonPopular> createState() => _IconButtonPopularState();
}

class _IconButtonPopularState extends State<IconButtonPopular> {
  late bool isLike;

  @override
  void initState() {
    isLike = widget.isLike;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.white,
        fixedSize: Size(34.w, 34.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: () {
        isLike
            ? context.read<LikeCubit>().unsaveLike(id: widget.id)
            : context.read<LikeCubit>().saveLike(id: widget.id);
        isLike = !isLike;
        setState(() {});
      },
      icon: isLike ? SvgPicture.asset(AppSvgs.heartFilled) : SvgPicture.asset(AppSvgs.heart),
    );
  }
}
