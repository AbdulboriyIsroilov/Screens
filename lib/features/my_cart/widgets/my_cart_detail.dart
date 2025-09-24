import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/cart_models/my_cart_model.dart';
import 'package:screens/features/my_cart/managers/my_cart_bloc.dart';
import 'package:screens/features/my_cart/managers/my_cart_event.dart';
import 'package:screens/features/my_cart/widgets/my_cart_button.dart';

import '../../../core/l10n/app_localizations.dart';

class MyCartDetail extends StatelessWidget {
  const MyCartDetail({
    super.key,
    required this.local,
    required this.items,
  });

  final MyLocalizations local;
  final CartItem items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 107.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: BoxBorder.all(color: AppColors.grey),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 14.h,
      ),
      child: Row(
        spacing: 16.w,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: CachedNetworkImage(
              imageUrl: items.image,
              width: 83.w,
              height: 79.h,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items.title,
                      style: AppStyles.w600s15,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<MyCartBloc>().add(
                          CartDeleteEvent(items.id),
                        );
                      },
                      child: SvgPicture.asset(
                        AppSvgs.trash,
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${local.size} ${items.size}",
                  style: AppStyles.w400s12,
                ),
                SizedBox(height: 18.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${items.price}",
                      style: AppStyles.w600s15,
                    ),
                    Row(
                      spacing: 10.5.w,
                      children: [
                        MyCartButton(svg: AppSvgs.minus),
                        Text(
                          "${items.quantity}",
                          style: AppStyles.w500s12,
                        ),
                        MyCartButton(
                          svg: AppSvgs.plus,
                          onPressed: () {
                            // context.read<MyCartBloc>().add(
                            //   CartAddEvent(MyCartAddModel(productId: state.mycart.items[index].productId, sizeId: 3)),
                            // );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
