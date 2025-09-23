import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/empty_widget.dart';
import 'package:screens/features/saved/managers/saved_bloc.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_svg.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../../common/widgets/loading_widget.dart';
import '../managers/saved_state.dart';
import '../widgets/product_card_small.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(
        title: local.saved_items,
        activ: 2,
      ),
      body: BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) => state.loading
            ? LoadingWidget()
            : state.savedProduct.isEmpty
            ? EmptyWidget(
                title1: local.saved_null_title1,
                title2: local.saved_null_title2,
                svg: AppSvgs.heartDuotone,
              )
            : GridView.builder(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 25.w, 100.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 19.w,
                  mainAxisSpacing: 24.h,
                  mainAxisExtent: 172.h,
                ),
                itemCount: state.savedProduct.length,
                itemBuilder: (context, index) {
                  return ProductCardSmall(
                    state: state.savedProduct[index],
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 2),
    );
  }
}
