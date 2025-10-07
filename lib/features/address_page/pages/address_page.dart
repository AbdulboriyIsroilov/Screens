import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/features/address_page/managers/address_bloc.dart';
import 'package:screens/features/address_page/managers/address_event.dart';
import 'package:screens/features/address_page/managers/address_state.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';
import '../../common/widgets/icon_text_button_popular.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(
        title: local.address,
        activ: 3,
        onPressed: () {
          context.go(Routers.checkout);
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 25.w, 0),
        child: Column(
          spacing: 14.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(local.saved_address, style: AppStyles.w600s16),
            Expanded(
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return state.addressEnum == EnumState.loading
                      ? LoadingWidget()
                      : ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ...List.generate(state.address.length, (index) {
                              final address = state.address[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: AppColors.grey,
                                    width: state.selectedIndex == index ? 1.5 : 1,
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
                                            children: [
                                              Text(address.title, style: AppStyles.w600s14),
                                              if (address.isDefault) ...[
                                                SizedBox(width: 6.w),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.grey,
                                                    borderRadius: BorderRadius.circular(4.r),
                                                  ),
                                                  child: Text(
                                                    local.default_card,
                                                    style: AppStyles.w500s12.copyWith(fontSize: 10),
                                                  ),
                                                ),
                                              ],
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
                                      groupValue: state.selectedIndex,
                                      activeColor: AppColors.black,
                                      onChanged: (val) {
                                        context.read<AddressBloc>().add(SelectAddressEvent(val!));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(height: 15.h),
                            IconTextButtonPopular(
                              icon: AppSvgs.plus,
                              title: local.add_new_address,
                              color: Colors.transparent,
                              fColor: AppColors.black,
                              onPressed: () {
                                context.push(Routers.addNewAddress);
                              },
                            ),
                            SizedBox(height: 40.h),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 15.h),
        child: SafeArea(
          child: TextButtonPopular(title: local.apply),
        ),
      ),
    );
  }
}
