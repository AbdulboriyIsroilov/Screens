import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/data/models/product_models/product_model.dart';
import 'package:screens/features/common/widgets/icon_button_popular.dart';

import '../../../core/utils/app_colors.dart';

class ProductCardBig extends StatelessWidget {
  const ProductCardBig({
    super.key,
    required this.state,
  });

  final ProductModel state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.push(Routers.productDetailsById(id: state.id));
      },
      child: SizedBox(
        width: 161.w,
        height: 224.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 161.w,
              height: 174.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImage(
                      imageUrl: state.image,
                      width: 161.w,
                      height: 174.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    left: 115.w,
                    child: IconButtonPopular(
                      isLike: state.isLiked,
                      id: state.id,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              state.title,
              style: theme.textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "\$ ${state.price}",
              style: AppStyles.w500s12.copyWith(
                color: AppColors.greyBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
