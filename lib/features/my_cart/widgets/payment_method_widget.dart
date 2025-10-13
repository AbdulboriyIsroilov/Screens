import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/payment_method/managers/card_bloc.dart';
import 'package:screens/features/payment_method/managers/card_state.dart';
import '../../../core/formatter.dart';

class PaymentMethodCard extends StatefulWidget {
  final String title;
  final ValueChanged<int>? onCardSelected; // 🔧 int ga o‘zgardi

  const PaymentMethodCard({
    super.key,
    required this.title,
    this.onCardSelected,
  });

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  String selected = "Card";

  final List<Map<String, dynamic>> payments = [
    {"icon": AppSvgs.card, "title": "Card"},
    {"icon": AppSvgs.cash, "title": "Cash"},
    {"icon": AppSvgs.apple, "title": "Pay"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Text(widget.title, style: AppStyles.w600s16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: payments.map((item) {
            final bool isSelected = selected == item["title"];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = item["title"];
                });
              },
              child: AnimatedContainer(
                width: 109.w,
                height: 36.h,
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? AppColors.black : AppColors.grey,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      item["icon"],
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.white : AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item["title"],
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        Container(
          width: 341.w,
          height: 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              if (state.loading) return const LoadingWidget();

              if (state.card.isEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("No cards found",
                        style: AppStyles.w500s16.copyWith(color: Colors.grey)),
                    GestureDetector(
                      onTap: () => context.push(Routers.card),
                      child: SvgPicture.asset(AppSvgs.edit),
                    ),
                  ],
                );
              }

              final karta = state.card.first;

              // 🔥 id ni int sifatida yuborish
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onCardSelected?.call(karta.id);
              });

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(maskCardNumber(karta.cardNumber),
                      style: AppStyles.w500s16),
                  GestureDetector(
                    onTap: () => context.go(Routers.card),
                    child: SvgPicture.asset(AppSvgs.edit),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
