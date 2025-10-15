import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routes.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/data/models/my_order_models/my_orders_create_model.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/my_cart/widgets/order_summary.dart';
import 'package:screens/features/my_orders/managers/order_bloc.dart';
import 'package:screens/features/my_orders/managers/order_event.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/show_diolog_modul.dart';
import '../widgets/delivery_address.dart';
import '../widgets/payment_method_widget.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final promoCodeController = TextEditingController();
  String selected = "Card";
  int? addressId;
  int? cardId;

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBarCommon(
        title: local.checkout,
        activ: 3,
        onPressed: () => context.go(Routes.cart),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 25.w, 31.h),
        child: Column(
          spacing: 20.h,
          children: [
            DeliveryAddressWidget(
              title: local.delivery_address,
              changeTitle: local.change,
              onAddressSelected: (id) => setState(() => addressId = id),
            ),
            Divider(color: theme.colorScheme.inversePrimary),
            PaymentMethodCard(
              title: local.payment_method,
              onCardSelected: (id) => setState(() => cardId = id),
            ),
            Divider(color: theme.colorScheme.inversePrimary),
            OrderSummery(local: local, promoCodeController: promoCodeController),
            const Spacer(),
            TextButtonPopular(
              title: local.place_order,
              color: theme.colorScheme.onInverseSurface,
              onPressed: () {
                if (addressId == null || cardId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Address or Card not selected"),
                    ),
                  );
                  return;
                }
                context.read<OrderBloc>().add(
                  MyOrderCreateEvent(
                    MyOrdersCreateModel(
                      addressId: addressId!,
                      cardId: cardId!,
                      paymentMethod: "Card",
                    ),
                  ),
                );
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ShowDiologModul(
                    title1: local.congratulations,
                    title2: local.your_order_been_placed,
                    titleButton: local.track_your_order,
                    onPressed: () {
                      context.go(Routes.account);
                    },
                  ),
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
