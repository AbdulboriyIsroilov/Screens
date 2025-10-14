import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/core/router/routers.dart';

import '../../../data/models/product_models/product_model.dart';

class SearchProductItem extends StatelessWidget {
  final ProductModel mahsulot;

  const SearchProductItem({super.key, required this.mahsulot});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Mahsulot rasmi + ma’lumotlar
            Row(
              spacing: 12.w,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CachedNetworkImage(
                    imageUrl: mahsulot.image,
                    width: 56.w,
                    height: 53.3.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mahsulot.title,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      "\$ ${mahsulot.price}",
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
              ],
            ),

            // Arrow Icon
            GestureDetector(
              onTap: () {
                context.push(Routers.productDetailsById(id: mahsulot.id));
              },
              child: SvgPicture.asset(
                AppSvgs.arrowTop,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimaryFixed,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),

        Divider(color: theme.colorScheme.inversePrimary),
      ],
    );
  }
}
