import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';

import '../../../core/l10n/app_localizations.dart';
import '../managers/my_cart_bloc.dart';
import '../managers/my_cart_state.dart';

class OrderSummery extends StatelessWidget {
  const OrderSummery({
    super.key,
    required this.local,
    required this.promoCodeController,
  });

  final MyLocalizations local;
  final TextEditingController promoCodeController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<MyCartBloc, MyCartState>(
      builder: (context, state) => state.loading
          ? LoadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                Text(local.order_summary, style: theme.textTheme.bodyMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      local.sub_total,
                      style: AppStyles.w400s16.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      "\$ ${state.mycart.subTotal}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      local.v_a_t,
                      style: AppStyles.w400s16.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      "\$ ${state.mycart.vat}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      local.shipping_fee,
                      style: AppStyles.w400s16.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      "\$ ${state.mycart.shippingFee}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                Divider(color: theme.colorScheme.inversePrimary),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(local.total, style: theme.textTheme.bodySmall ),
                    Text(
                      "\$ ${state.mycart.total}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: promoCodeController,
                      style: theme.textTheme.bodyLarge,
                      cursorColor: theme.colorScheme.onInverseSurface,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 150.w,
                          maxWidth: 249.w,
                        ),
                        hintText: local.enter_promo_code,
                        hintStyle: AppStyles.w400s16.copyWith(
                          color: AppColors.textGrey,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 22.62.w,
                            right: 12.37.w,
                          ),
                          child: SvgPicture.asset(AppSvgs.discount),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 21.w,
                          minHeight: 21.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: theme.colorScheme.inversePrimary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: theme.colorScheme.inversePrimary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: theme.colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                    TextButtonPopular(
                      title: local.add,
                      width: 83,
                      color: theme.colorScheme.onInverseSurface,
                      height: 51,
                      border: false,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
