import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/my_orders/managers/order_state.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../managers/order_bloc.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBarCommon(
        title: local.my_orders,
        activ: 5,
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 25.w, 0),
        child: Column(
          children: [
            Container(
              height: 54.h,
              width: 341.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: theme.colorScheme.primaryFixed,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(9.w),
                labelColor: theme.colorScheme.onPrimaryFixed,
                unselectedLabelColor: AppColors.greyBlack,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: double.infinity,
                      height: 38.h,
                      child: Center(child: Text("Ongoing", style: AppStyles.w500s14t)),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: double.infinity,
                      height: 38.h,
                      child: Center(child: Text("Completed", style: AppStyles.w500s14t)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 5.h, bottom: 100.h),
                      itemCount: state.orders.length,
                      separatorBuilder: (context, index) => SizedBox(height: 20.h),
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return Container(
                          width: 342.w,
                          height: 107.h,
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: theme.colorScheme.inversePrimary,width: 1.5),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
                          child: Row(
                            spacing: 16.w,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: CachedNetworkImage(
                                  imageUrl: order.image,
                                  width: 83.w,
                                  height: 79.h,
                                  fit: BoxFit.cover,
                                  ),
                              ),
                              SizedBox(
                                width: 208.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(order.title, style: AppStyles.w600s14),
                                            Text("Size ${order.size}", style: AppStyles.w400s12),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 60.w,
                                          height: 20.h,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              backgroundColor: AppColors.grey,
                                              disabledBackgroundColor: AppColors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6.r),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "In Transit",
                                              style: AppStyles.w500s12.copyWith(fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("\$ ${order.price}", style: AppStyles.w600s14),
                                        SizedBox(
                                          width: 90.w,
                                          height: 30.h,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: theme.colorScheme.onInverseSurface,
                                              disabledBackgroundColor: AppColors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6.r),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Track Order",
                                              style: AppStyles.w500s12.copyWith(fontSize: 10, color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(child: Text("Completed orders here")),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 4),
    );
  }
}
