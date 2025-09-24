import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/l10n/app_localizations.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/icon_button_popular.dart';
import 'package:screens/features/common/widgets/icon_text_button_popular.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_cubit.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_state.dart';
import 'package:screens/features/product_dateil/widgets/diolog.dart';
import 'package:screens/features/product_dateil/widgets/reviews_widget.dart';

import '../../../data/models/cart_models/my_cart_add_model.dart';
import '../../my_cart/managers/my_cart_bloc.dart';
import '../../my_cart/managers/my_cart_event.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String _selectedFilter = "Most Relevant";
  int? _selectedSizeId;
  final List<String> _filters = [
    "Most Relevant",
    "Newest",
    "Oldest",
    "Highest Rating",
    "Lowest Rating",
  ];

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return BlocBuilder<ProductDateilCubit, ProductDetailState>(
      builder: (context, state) => Scaffold(
        extendBody: true,
        appBar: AppBarCommon(
          title: local.details,
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
                          Text(
                            "${state.detail.rating.toStringAsFixed(1)}/5",
                            style: AppStyles.w500s16,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "(${state.detail.reviewsCount} ${local.reviews})",
                            style: AppStyles.w400s16,
                          ),
                        ],
                      ),
                      Text(state.detail.description, style: AppStyles.w400s16),
                      Text("Choose size", style: AppStyles.w600s20),
                      Row(
                        children: List.generate(
                          state.detail.productSizes.length,
                          (index) {
                            final size = state.detail.productSizes[index];
                            final isSelected = _selectedSizeId == size.id;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedSizeId = size.id;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.w),
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: isSelected ? AppColors.succes : AppColors.grey,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  color: isSelected ? AppColors.succes.withOpacity(0.1) : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  size.title,
                                  style: AppStyles.w500s20.copyWith(
                                    color: isSelected ? AppColors.succes : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            state.detail.rating.toStringAsFixed(1),
                            style: AppStyles.w600s64,
                          ),
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
                                          child: SvgPicture.asset(
                                            AppSvgs.starBloon,
                                          ),
                                        );
                                }),
                              ),
                              Text(
                                "${state.detail.reviewsCount} ${local.ratings}",
                                style: AppStyles.w400s16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${state.reviews.length} ${local.reviews}",
                            style: AppStyles.w600s16,
                          ),
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
                            return ReviewsWidget(review: review);
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
                  Text(local.price, style: AppStyles.w400s16),
                  Text("\$ ${state.detail.price}", style: AppStyles.w600s25),
                ],
              ),
              IconTextButtonPopular(
                icon: AppSvgs.bag,
                title: local.add_to_cart,
                width: 240,
                height: 54,
                onPressed: () {
                  if (_selectedSizeId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Iltimos, avval o‘lcham tanlang"),
                      ),
                    );
                    return;
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Diolog(local: local);
                      },
                    );
                    context.read<MyCartBloc>().add(
                      CartAddEvent(MyCartAddModel(productId: state.detail.id, sizeId: _selectedSizeId!)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
