import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/icon_button_popular.dart';
import 'package:screens/features/common/widgets/icon_text_button_popular.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_cubit.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_state.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String _selectedFilter = "Most Relevant";

  final List<String> _filters = [
    "Most Relevant",
    "Newest",
    "Oldest",
    "Highest Rating",
    "Lowest Rating",
  ];

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
        body: state.loading
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 10.h, 25.w, 125.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.h,
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
                              child: IconButtonPopular(
                                isLike: state.detail.isLiked,
                                id: state.detail.id,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(state.detail.title, style: AppStyles.w600s25),
                      Row(
                        children: [
                          SvgPicture.asset(AppSvgs.star),
                          SizedBox(width: 4.w),
                          Text("${state.detail.rating.toStringAsFixed(1)}/5", style: AppStyles.w500s16),
                          SizedBox(width: 6.w),
                          Text("(${state.detail.reviewsCount} reviews)", style: AppStyles.w400s16),
                        ],
                      ),
                      Text(state.detail.description, style: AppStyles.w400s16),
                      Text("Choose size", style: AppStyles.w600s20),
                      Row(
                        children: List.generate(state.detail.productSizes.length, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10.w),
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColors.grey),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              state.detail.productSizes[index].title,
                              style: AppStyles.w500s20,
                            ),
                          );
                        }),
                      ),
                      Row(
                        children: [
                          Text(state.detail.rating.toStringAsFixed(1), style: AppStyles.w600s64),
                          SizedBox(width: 18.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 9.w,
                                children: List.generate(5, (index) {
                                  return index < state.detail.rating.floor()
                                      ? SvgPicture.asset(AppSvgs.star)
                                      : SizedBox(
                                          width: 19.w,
                                          height: 19.h,
                                          child: SvgPicture.asset(AppSvgs.starBloon),
                                        );
                                }),
                              ),
                              Text("${state.detail.reviewsCount} Ratings", style: AppStyles.w400s16),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${state.reviews.length} Reviews", style: AppStyles.w600s16),
                          DropdownButton<String>(
                            value: _selectedFilter,
                            underline: const SizedBox(),
                            icon: SvgPicture.asset(AppSvgs.chevron),
                            style: AppStyles.w500s12,
                            items: _filters.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedFilter = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ...List.generate(state.reviews.length, (index) {
                            final review = state.reviews[index];
                            return Column(
                              spacing: 6.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 6.w,
                                  children: List.generate(5, (i) {
                                    return i < review.rating
                                        ? SizedBox(
                                            width: 17.w,
                                            height: 15.5.h,
                                            child: SvgPicture.asset(AppSvgs.star),
                                          )
                                        : SizedBox(
                                            width: 17.w,
                                            height: 15.5.h,
                                            child: SvgPicture.asset(AppSvgs.starBloon),
                                          );
                                  }),
                                ),
                                Text(
                                  review.comment,
                                  style: AppStyles.w400s14,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  spacing: 8.w,
                                  children: [
                                    Text(review.userFullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text(
                                      "• ${DateFormat('d MMM, HH:mm').format(DateTime.parse(review.created))}",
                                      style: AppStyles.w400s14,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.grey,
                                ),
                              ],
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
            border: Border(top: BorderSide(color: AppColors.grey)),
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
