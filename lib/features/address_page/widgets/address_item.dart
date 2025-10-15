import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/address_page/managers/address_bloc.dart';
import 'package:screens/features/address_page/managers/address_event.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../data/models/address_models/addres_model.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.address,
    required this.index,
    required this.selectedIndex,
    required this.local,
    required this.theme,
  });

  final AddressModel address;
  final int index;
  final int? selectedIndex;
  final MyLocalizations local;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: theme.colorScheme.inversePrimary,
          width: selectedIndex == index ? 2 : 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppSvgs.location),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 5.w,
                  children: [
                    SizedBox(
                      width: 115.w,
                      child: Text(
                        address.nickname,
                        style: AppStyles.w600s14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (address.isDefault) ...[
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          local.default_card,
                          style: AppStyles.w500s12,
                        ),
                      ),
                    ],
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
                        context
                            .read<AddressBloc>()
                            .add(AddressDeleteEvent(address.id));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  address.fullAddress,
                  style: AppStyles.w400s14.copyWith(color: AppColors.textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Radio<int>(
            value: index,
            groupValue: selectedIndex,
            activeColor: AppColors.succes,
            onChanged: (val) {
              context.read<AddressBloc>().add(SelectAddressEvent(val!));
            },
          ),
        ],
      ),
    );
  }
}
