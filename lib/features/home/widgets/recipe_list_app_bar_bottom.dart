import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/features/home/widgets/search_text_field.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_svg.dart';
import '../managers/home_cubit.dart';
import '../managers/home_state.dart';
import 'bottom_item.dart';

final controller = ScrollController();

class RecipeListAppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const RecipeListAppBarBottom({
    super.key,
    required this.selectedIndex,
    required this.searchController,
  });

  final int selectedIndex;
  final TextEditingController searchController;

  @override
  Size get preferredSize => Size(double.infinity, 110.h);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (conetext) => HomeCubit(categoriesRep: conetext.read(), productRepo: context.read()),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Column(
          spacing: 10.h,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 10.h, 25.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  search_text_field(controller: searchController),
                  Ink(
                    decoration: ShapeDecoration(
                      color: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        fixedSize: Size(52.w, 52.h),
                      ),
                      onPressed: () {},
                      icon: SvgPicture.asset(AppSvgs.filter),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, right: 25.w),
                child: Row(
                  spacing: 8.w,
                  children: [
                    BottomItem(title: "All", isSelected: selectedIndex == 0, id: 0),
                    ...List.generate(
                    state.categories.length,
                    (index) => BottomItem(
                      id: state.categories[index].id,
                      title: state.categories[index].title,
                      isSelected: state.categories[index].id == selectedIndex,
                    ),
                  ),]
                ),
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
