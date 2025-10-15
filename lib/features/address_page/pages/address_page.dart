import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/features/address_page/managers/address_bloc.dart';
import 'package:screens/features/address_page/managers/address_event.dart';
import 'package:screens/features/address_page/managers/address_state.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../common/widgets/icon_text_button_popular.dart';
import '../widgets/address_item.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(
        title: local.address,
        activ: 3,
        onPressed: () {
          context.go(Routes.checkout);
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 25.w, 0),
        child: Column(
          spacing: 14.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(local.saved_address, style: theme.textTheme.bodyMedium),
            Expanded(
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return state.addressEnum == EnumState.loading
                      ? LoadingWidget()
                      : RefreshIndicator(
                          onRefresh: () async {
                            Future.delayed(Duration(milliseconds: 500));
                            context.read<AddressBloc>().add(AddressListEvent());
                          },
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 40.h),
                            itemCount: state.address.length + 1,
                            itemBuilder: (context, index) {
                              if (index == state.address.length) {
                                return Column(
                                  children: [
                                    SizedBox(height: 15.h),
                                    IconTextButtonPopular(
                                      icon: AppSvgs.plus,
                                      title: local.add_new_address,
                                      color: Colors.transparent,
                                      fColor: theme.colorScheme.onPrimaryFixed,
                                      onPressed: () {
                                        context.push(Routes.addNewAddress);
                                      },
                                    ),
                                  ],
                                );
                              }
                              final address = state.address[index];
                              return AddressItem(
                                address: address,
                                index: index,
                                selectedIndex: state.selectedIndex,
                                local: local,
                                theme: theme,
                              );
                            },
                          ),
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
          child: TextButtonPopular(
            title: local.apply,
            border: false,
            color: theme.colorScheme.onInverseSurface,
          ),
        ),
      ),
    );
  }
}
