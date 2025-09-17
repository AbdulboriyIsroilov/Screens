import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/home/managers/home_cubit.dart';
import 'package:screens/features/home/managers/home_state.dart';

import '../../../core/utils/app_colors.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../widgets/recipe_list_app_bar_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.categoryId});
  final int categoryId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  bool all = true,ontap = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (conetext) => HomeCubit(categoriesRep: conetext.read(), productRepo: context.read()),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          extendBody: true,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              "Discover",
              style: AppStyles.w500s32,
            ),
            actions: [
              SvgPicture.asset(AppSvgs.bell),
              SizedBox(width: 25.w),
            ],
            bottom: RecipeListAppBarBottom(selectedIndex: widget.categoryId, searchController: controller,),
          ),
          body: GridView.builder(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 25.w, 100.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 19.w,
              mainAxisSpacing: 20.h,
              mainAxisExtent: 224.h,
            ),
            itemCount: state.product.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 161.w,
                height: 224.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CachedNetworkImage(
                        imageUrl: state.product[index].image,
                        width: 161.w,
                        height: 174.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      state.product[index].title,
                      style: AppStyles.w600s16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$ ${state.product[index].price}",
                      style: AppStyles.w500s12.copyWith(color: AppColors.greyBlack),
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BottomNavigationBarMain(),
            ],
          ),
        ),
      ),
    );
  }
}
