import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/address_page/managers/address_bloc.dart';
import 'package:screens/features/address_page/managers/address_state.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import '../../../core/utils/enum_state.dart';

class DeliveryAddressWidget extends StatefulWidget {
  final String title;
  final String changeTitle;
  final ValueChanged<int>? onAddressSelected; // 🔧 int ga o‘zgardi

  const DeliveryAddressWidget({
    super.key,
    required this.title,
    required this.changeTitle,
    this.onAddressSelected,
  });

  @override
  State<DeliveryAddressWidget> createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      spacing: 16.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: theme.textTheme.bodyMedium),
            GestureDetector(
              onTap: () => context.go(Routers.address),
              child: Text(
                widget.changeTitle,
                style: AppStyles.w500s14.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state.addressEnum == EnumState.loading) {
              return const LoadingWidget();
            }

            if (state.address.isEmpty) {
              return Text("No address found", style: AppStyles.w500s14);
            }

            final address = state.address.last;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onAddressSelected?.call(address.id);
            });

            return Row(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppSvgs.location),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.title, style: AppStyles.w600s14),
                    SizedBox(
                      width: 263,
                      child: Text(
                        address.fullAddress,
                        style: AppStyles.w400s14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
