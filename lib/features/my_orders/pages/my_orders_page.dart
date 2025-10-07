import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import '../../../core/l10n/app_localizations.dart';

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
    return Scaffold(
      appBar: AppBarCommon(
        title: local.my_orders,
        activ: 5,
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 25.w, 56.h),
        child: Column(
          children: [
            Container(
              height: 54.h,
              width: 341.w,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(9.w),
                labelColor: AppColors.black,
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
                children: const [
                  Center(child: Text("Ongoing orders here")),
                  Center(child: Text("Completed orders here")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
