import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';

import '../managers/home_bloc.dart';
import '../managers/home_event.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _selectedSort = "Relevance";
  String? _selectedSize;

  final Map<String, int> sizeMap = {
    "S": 1,
    "M": 2,
    "L": 3,
    "XL": 4,
    "XXL": 5,
    "XXXL": 6,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.5.w, 10.h, 24.5.w, 31.h),
      child: Column(
        spacing: 10.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            spacing: 7.h,
            children: [
              Container(
                width: 64.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filters", style: AppStyles.w600s20),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(AppSvgs.cancel),
                  ),
                ],
              ),
              Divider(color: AppColors.grey),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  Text("Sort By", style: AppStyles.w600s16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSortButton("Relevance"),
                        const SizedBox(width: 8),
                        _buildSortButton("Price: Low - High"),
                        const SizedBox(width: 8),
                        _buildSortButton("Price: High - Low"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: AppColors.grey),
          Column(
            spacing: 5.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price", style: AppStyles.w600s16),
                  Text(
                    "\$${_minPrice.toInt()} - \$${_maxPrice.toInt()}",
                    style: AppStyles.w400s14.copyWith(color: AppColors.textGrey),
                  ),
                ],
              ),
              RangeSlider(
                values: RangeValues(_minPrice, _maxPrice),
                min: 0,
                max: 2000,
                divisions: 2000,
                labels: RangeLabels("\$${_minPrice.toInt()}", "\$${_maxPrice.toInt()}"),
                onChanged: (values) {
                  setState(() {
                    _minPrice = values.start;
                    _maxPrice = values.end;
                  });
                },
              ),
            ],
          ),
          Divider(color: AppColors.grey),
          Column(
            spacing: 7.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Size", style: AppStyles.w600s16),
                  DropdownButton<String>(
                    value: _selectedSize,
                    items: sizeMap.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value!;
                      });
                    },
                  ),
                ],
              ),
              TextButtonPopular(
                title: "Apply Filters",
                border: false,
                onPressed: () {
                  final sizeId = _selectedSize != null ? sizeMap[_selectedSize]! : null;

                  if (sizeId != null) {
                    context.read<HomeBloc>().add(
                      FetchProductsEvent(
                        sizeId: sizeId,
                        minPrice: _minPrice.toInt(),
                        maxPrice: _maxPrice.toInt(),
                      ),
                    );
                  } else {
                    context.read<HomeBloc>().add(
                      FetchProductsEvent(
                        minPrice: _minPrice.toInt(),
                        maxPrice: _maxPrice.toInt(),
                      ),
                    );
                  }

                  context.pop();
                },
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSortButton(String text) {
    final bool isSelected = _selectedSort == text;
    return GestureDetector(
      onTap: () => setState(() => _selectedSort = text),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.grey),
        ),
        child: Text(
          text,
          style: AppStyles.w500s16.copyWith(color: isSelected ? AppColors.white : AppColors.black),
        ),
      ),
    );
  }
}
