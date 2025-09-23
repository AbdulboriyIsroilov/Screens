import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/home/managers/home_cubit.dart';
import 'package:screens/features/home/managers/home_state.dart';
import 'package:screens/features/home/widgets/product_card_big.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../widgets/home_app_bar_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  bool all = true, ontap = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            local.discover,
            style: AppStyles.w500s32,
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push(Routers.notifications, extra: {"index": 0});                },
              icon: SvgPicture.asset(AppSvgs.bell),
            ),
            SizedBox(width: 25.w),
          ],
          bottom: HomeAppBarBottom(
            selectedIndex: state.isSellect,
            searchController: controller,
          ),
        ),
        body: state.loadingProduct
            ? LoadingWidget()
            : GridView.builder(
                padding: EdgeInsets.fromLTRB(24.w, 8.h, 25.w, 100.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 19.w,
                  mainAxisSpacing: 20.h,
                  mainAxisExtent: 224.h,
                ),
                itemCount: state.product.length,
                itemBuilder: (context, index) {
                  return ProductCardBig(
                    state: state.product[index],
                  );
                },
              ),
        bottomNavigationBar: BottomNavigationBarMain(isActive: 0),
      ),
    );
  }
}
