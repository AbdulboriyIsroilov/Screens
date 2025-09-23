import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/my_cart/managers/my_cart_bloc.dart';
import 'package:screens/features/my_cart/managers/my_cart_state.dart';
import 'package:screens/features/my_cart/pages/my_cart_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: AppBarCommon(title: local.my_cart, activ: 3),
      body: BlocBuilder<MyCartBloc, MyCartState>(
        builder: (context, state) => Padding(
          padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 100.h),
          child: Column(
            spacing: 16.h,
            children: [
              Column(
                spacing: 14.h,
                children: List.generate(state.mycart.items.length, (index) {
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
                            imageUrl: state.mycart.items[index].image,
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
                                    state.mycart.items[index].title,
                                    style: AppStyles.w600s15,
                                  ),
                                  SvgPicture.asset(AppSvgs.trash),
                                ],
                              ),
                              Text(
                                "${local.size} ${state.mycart.items[index].size}",
                                style: AppStyles.w400s12,
                              ),
                              SizedBox(height: 18.5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$ ${state.mycart.items[index].price}",
                                    style: AppStyles.w600s15,
                                  ),
                                  Row(
                                    spacing: 10.5.w,
                                    children: [
                                      MyCartButton(svg: AppSvgs.minus),
                                      Text("${state.mycart.items[index].quantity}", style: AppStyles.w500s12),
                                      MyCartButton(svg: AppSvgs.plus),
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
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.sub_total, style: AppStyles.w400s16),
                  Text("\$ ${state.mycart.subTotal}", style: AppStyles.w500s16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.v_a_t, style: AppStyles.w400s16),
                  Text("\$ ${state.mycart.vat}", style: AppStyles.w500s16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.shipping_fee, style: AppStyles.w400s16),
                  Text("\$ ${state.mycart.shippingFee}", style: AppStyles.w500s16),
                ],
              ),
              Divider(color: AppColors.greyDark),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.total, style: AppStyles.w400s16),
                  Text("\$ ${state.mycart.total}", style: AppStyles.w500s16),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 3),
    );
  }
}
