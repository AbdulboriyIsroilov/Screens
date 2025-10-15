import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/address_models/add_new_address_model.dart';
import 'package:screens/features/address_page/managers/address_bloc.dart';
import 'package:screens/features/address_page/managers/address_event.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../common/widgets/show_diolog_modul.dart';

class AddressBottomSheet extends StatefulWidget {
  final TextEditingController addressNameController;
  final TextEditingController fullAddressController;
  final double lat;
  final double lng;
  final String fullAddress;
  final bool isDefault;
  final ValueChanged<bool> onDefaultChanged;

  const AddressBottomSheet({
    super.key,
    required this.addressNameController,
    required this.fullAddressController,
    required this.lat,
    required this.lng,
    required this.fullAddress,
    required this.isDefault,
    required this.onDefaultChanged,
  });

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  bool isDefaultLocal = false;

  @override
  void initState() {
    super.initState();
    isDefaultLocal = widget.isDefault;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.fromLTRB(24.5.w, 14.h, 24.5.w, 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20.h,
        children: [
          Column(
            spacing: 14.h,
            children: [
              Container(width: 50.w, height: 4.h, color: AppColors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.address, style: theme.textTheme.labelLarge),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppSvgs.cancel,
                      colorFilter: ColorFilter.mode(theme.colorScheme.onPrimaryFixed, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: AppColors.grey),
          Column(
            spacing: 10.h,
            children: [
              TextFieldNotPasword(
                controller: widget.addressNameController,
                title: local.address_nickname,
                hint: local.give_name_the_address,
                suffixicon: true,
              ),
              TextFieldNotPasword(
                controller: widget.fullAddressController,
                title: local.full_address,
                hint: local.enter_your_full_address,
                suffixicon: true,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isDefaultLocal,
                    onChanged: (val) {
                      setState(() {
                        isDefaultLocal = val ?? false;
                      });
                      widget.onDefaultChanged(isDefaultLocal);
                    },
                  ),
                  Text(local.make_this_default_address),
                ],
              ),
            ],
          ),
          TextButtonPopular(
            title: local.add,
            border: false,
            color: theme.colorScheme.onInverseSurface,
            onPressed: () {
              context.read<AddressBloc>().add(
                AddNewAddressEvent(
                  AddNewAddressModel(
                    nickname: widget.addressNameController.text,
                    fullAddress: widget.fullAddress,
                    lat: widget.lat,
                    lng: widget.lng,
                    isDefault: isDefaultLocal,
                  ),
                ),
              );

              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return ShowDiologModul(
                    title1: local.congratulations,
                    title2: local.your_new_address_been_added,
                    titleButton: local.thanks,
                    onPressed: () {
                      context.pop();
                      context.go(Routes.address);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
