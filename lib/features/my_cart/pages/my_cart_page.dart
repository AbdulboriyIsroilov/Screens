import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/empty_widget.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/my_cart/managers/my_cart_bloc.dart';
import 'package:screens/features/my_cart/managers/my_cart_state.dart';
import 'package:screens/features/my_cart/widgets/my_cart_detail.dart';
import 'package:screens/features/onboarding/widgets/onboarding_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBarCommon(title: local.my_cart, activ: 3),
      body: BlocBuilder<MyCartBloc, MyCartState>(
        builder: (context, state) => state.loading
            ? LoadingWidget()
            : state.mycart.items.isEmpty
            ? EmptyWidget(
                title1: local.your_cart_is_empty,
                title2: local.when_you_add_products_theyll_appear_here,
                svg: AppSvgs.cartDuotone,
              )
            : Padding(
              padding: EdgeInsets.fromLTRB(24.w, 15.h, 24.w, 100.h),
              child: Column(
                spacing: 16.h,
                children: [
                  SizedBox(
                    height: 363.h,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          spacing: 14.h,
                          children: List.generate(state.mycart.items.length, (
                            index,
                          ) {
                            return MyCartDetail(
                              local: local,
                              items: state.mycart.items[index],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(local.sub_total, style: AppStyles.w400s16),
                      Text(
                        "\$ ${state.mycart.subTotal}",
                        style: AppStyles.w500s16,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(local.v_a_t, style: AppStyles.w400s16),
                      Text(
                        "\$ ${state.mycart.vat}",
                        style: AppStyles.w500s16,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(local.shipping_fee, style: AppStyles.w400s16),
                      Text(
                        "\$ ${state.mycart.shippingFee}",
                        style: AppStyles.w500s16,
                      ),
                    ],
                  ),
                  Divider(color: AppColors.greyDark),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(local.total, style: AppStyles.w400s16),
                      Text(
                        "\$ ${state.mycart.total}",
                        style: AppStyles.w500s16,
                      ),
                    ],
                  ),
                  Spacer(),
                  OnboardingButton(
                    title: local.go_to_checkout,
                    onPressed: () {
                      context.push(Routers.card);
                    },
                  ),
                ],
              ),
            ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 3),
    );
  }
}
