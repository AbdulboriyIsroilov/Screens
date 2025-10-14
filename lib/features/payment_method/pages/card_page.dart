import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/icon_text_button_popular.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/payment_method/managers/card_bloc.dart';
import 'package:screens/features/payment_method/managers/card_state.dart';
import '../../../core/l10n/app_localizations.dart';
import '../managers/card_event.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: AppBarCommon(
        title: local.payment_method,
        activ: 3,
        onPressed: () {
          context.go(Routers.checkout);
        },
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 100.h),
              child: Column(
                spacing: 15.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(local.saved_cards, style: theme.textTheme.bodyMedium),
                  Column(
                    spacing: 12.h,
                    children: List.generate(state.card.length, (index) {
                      final card = state.card[index];
                      return Container(
                        width: 341.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.inversePrimary, width: 1.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}",
                                style: AppStyles.w600s15,
                              ),
                            ),
                            if (card.isDefault)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: AppColors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  local.default_card,
                                  style: AppStyles.w400s12,
                                ),
                              ),
                            SizedBox(width: 8.w),
                            Radio<int>(
                              value: card.id,
                              groupValue: state.selectedCardId,
                              onChanged: (val) {
                                context.read<CardBloc>().add(SelectCardEvent(val!));
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  IconTextButtonPopular(
                    icon: AppSvgs.plus,
                    title: local.add_new_card,
                    color: Colors.transparent,
                    fColor: theme.colorScheme.onPrimaryFixed,
                    onPressed: () {
                      context.push(Routers.newCard);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 86.h,
        color: theme.colorScheme.primaryFixed,
        alignment: Alignment.center,
        child: TextButtonPopular(
          title: local.apply,
          color: theme.colorScheme.onInverseSurface,
          border: false,
          onPressed: () {
            context.go(Routers.checkout);
          },
        ),
      ),
    );
  }
}
