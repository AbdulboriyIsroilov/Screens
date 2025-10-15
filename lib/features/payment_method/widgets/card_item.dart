import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/payment_method/managers/card_bloc.dart';
import 'package:screens/features/payment_method/managers/card_event.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../data/models/card_models/card_model.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.card,
    required this.selectedCardId,
    required this.local,
    required this.theme,
  });

  final CardModel card;
  final int? selectedCardId;
  final MyLocalizations local;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341.w,
      height: 52.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.inversePrimary,
          width: selectedCardId == card.id ? 2 : 1.5,
        ),
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
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                local.delete,
                style: AppStyles.w500s12.copyWith(color: AppColors.error),
              ),
            ),
            onTap: () {
              context.read<CardBloc>().add(CardDeleteEvent(card.id));
            },
          ),
          Radio<int>(
            value: card.id,
            groupValue: selectedCardId,
            activeColor: AppColors.succes,
            onChanged: (val) {
              context.read<CardBloc>().add(SelectCardEvent(val!));
            },
          ),
        ],
      ),
    );
  }
}
