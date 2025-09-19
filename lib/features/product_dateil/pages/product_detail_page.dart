import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/icon_button_popular.dart';
import 'package:screens/features/common/widgets/icon_text_button_popular.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_cubit.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_state.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDateilCubit, ProductDetailState>(
      builder: (context, state) => Scaffold(
        extendBody: true,
        appBar: AppBarCommon(
          title: "Details",
          activ: 1,
          onPressed: () {
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 10.h, 25.w, 75.h),
            child: state.loading
                ? LoadingWidget()
                : Column(
                    spacing: 12.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 341.w,
                        height: 368.5.h,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                state.detail.productImages.first.image,
                                width: 341.w,
                                height: 368.5.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 16.h,
                              left: 277.w,
                              child: IconButtonPopular(isLike: state.detail.isLiked, id: state.detail.id),
                            ),
                          ],
                        ),
                      ),
                      Text(state.detail.title, style: AppStyles.w600s25),
                      Row(
                        spacing: 4.w,
                        children: [
                          SvgPicture.asset(AppSvgs.star),
                          Text("${state.detail.rating.toStringAsFixed(1)}/5", style: AppStyles.w500s16),
                          Text("(${state.detail.reviewsCount} reviews)", style: AppStyles.w400s16),
                        ],
                      ),
                      Text(state.detail.description, style: AppStyles.w400s16),
                      Text("Choose size", style: AppStyles.w600s20),
                      Row(
                        spacing: 10.w,
                        children: [
                          ...List.generate(state.detail.productSizes.length, (index) {
                            return Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: BoxBorder.all(color: AppColors.grey),
                              ),
                              alignment: Alignment.center,
                              child: Text(state.detail.productSizes[index].title, style: AppStyles.w500s20),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 105.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: BoxBorder.fromLTRB(top: BorderSide(color: AppColors.grey)),
          ),
          padding: EdgeInsets.fromLTRB(24.w, 20.h, 25.w, 31.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Price", style: AppStyles.w400s16),
                  Text("\$ ${state.detail.price}", style: AppStyles.w600s25),
                ],
              ),
              IconTextButtonPopular(
                icon: AppSvgs.bag,
                title: "Add to Cart",
                width: 240,
                height: 54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
