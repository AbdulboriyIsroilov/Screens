import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/my_cart/widgets/order_summary.dart';
import 'package:screens/features/my_cart/widgets/payment_method_widget.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/show_diolog_modul.dart';
import '../widgets/delivery_address.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final promoCodeController = TextEditingController();
  String selected = "Card";

  final List<Map<String, dynamic>> payments = [
    {"icon": AppSvgs.card, "title": "Card"},
    {"icon": AppSvgs.cash, "title": "Cash"},
    {"icon": AppSvgs.apple, "title": "Pay"},
  ];

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(
        title: local.checkout,
        activ: 3,
        onPressed: () {
          context.go(Routers.cart);
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 25.w, 31.h),
        child: Column(
          spacing: 20.h,
          children: [
            DeliveryAddressWidget(
              title: local.delivery_address,
              changeTitle: local.change,
            ),
            const Divider(color: AppColors.grey),
            PaymentMethodCard(title: local.payment_method),
            const Divider(color: AppColors.grey),
            OrderSummery(local: local, promoCodeController: promoCodeController),
            const Spacer(),
            TextButtonPopular(
              title: local.place_order,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return ShowDiologModul(
                      title1: local.congratulations,
                      title2: local.your_order_been_placed,
                      titleButton: local.track_your_order,
                      onPressed: () {
                        context.pop();
                        // context.go(Routers.card);
                      },
                    );
                  },
                );
              },
              border: false,
            ),
          ],
        ),
      ),
    );
  }
}
