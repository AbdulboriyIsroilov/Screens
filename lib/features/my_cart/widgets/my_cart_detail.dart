import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/cart_models/my_cart_model.dart';
import 'package:screens/features/my_cart/managers/my_cart_bloc.dart';
import 'package:screens/features/my_cart/managers/my_cart_event.dart';
import 'package:screens/features/my_cart/widgets/my_cart_button.dart';
import '../../../core/l10n/app_localizations.dart';

class MyCartDetail extends StatefulWidget {
  const MyCartDetail({
    super.key,
    required this.local,
    required this.items,
  });

  final MyLocalizations local;
  final CartItem items;

  @override
  State<MyCartDetail> createState() => _MyCartDetailState();
}

class _MyCartDetailState extends State<MyCartDetail> {
  late int quantity;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.quantity;
  }

  void _onQuantityChanged(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });

    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      context.read<MyCartBloc>().add(
        CartUpdateEvent(widget.items.id, quantity),
      );
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 342.w,
      height: 107.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: theme.colorScheme.inversePrimary, width: 1.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
      child: Row(
        spacing: 16.w,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: CachedNetworkImage(
              imageUrl: widget.items.image,
              width: 83.w,
              height: 79.h,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.items.title, style: AppStyles.w600s15),
                    GestureDetector(
                      onTap: () {
                        context.read<MyCartBloc>().add(
                          CartDeleteEvent(widget.items.id),
                        );
                      },
                      child: SvgPicture.asset(
                        AppSvgs.trash,
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
                Text("${widget.local.size} ${widget.items.size}", style: AppStyles.w400s12),
                SizedBox(height: 18.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$ ${widget.items.price}", style: AppStyles.w600s15),
                    Row(
                      spacing: 10.5.w,
                      children: [
                        MyCartButton(
                          svg: AppSvgs.minus,
                          onPressed: quantity > 1
                              ? () => _onQuantityChanged(quantity - 1)
                              : null,
                        ),
                        Text(
                          "$quantity",
                          style: theme.textTheme.displaySmall,
                        ),
                        MyCartButton(
                          svg: AppSvgs.plus,
                          onPressed: () => _onQuantityChanged(quantity + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
