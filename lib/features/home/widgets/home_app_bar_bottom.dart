import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screens/features/home/managers/home_bloc.dart';
import 'package:screens/features/home/widgets/search_text_field.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_svg.dart';
import '../managers/home_state.dart';
import 'bottom_item.dart';
import 'filter_sheet.dart';

final controller = ScrollController();

class HomeAppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarBottom({
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
    MyLocalizations local = MyLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Column(
        spacing: 10.h,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 10.h, 25.w, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchTextField(
                  controller: searchController,
                  search: local.search_for_clothes,
                ),
                Ink(
                  decoration: ShapeDecoration(
                    color: theme.colorScheme.onInverseSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: IconButton(
                    style: IconButton.styleFrom(
                      fixedSize: Size(52.w, 52.h),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => BlocProvider.value(
                          value: context.read<HomeBloc>(),
                          child: const FilterSheet(),
                        ),
                      );
                    },
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
                  BottomItem(title: local.all, isSelected: selectedIndex == -1, id: -1),
                  ...List.generate(
                    state.categories.length,
                    (index) => BottomItem(
                      id: state.categories[index].id,
                      title: state.categories[index].title,
                      isSelected: state.categories[index].id == selectedIndex,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
