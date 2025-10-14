import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../widgets/address_map_widget.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  final controller = MapController();
  final addressNameController = TextEditingController();
  final fullAddressController = TextEditingController();
  bool isDefault = false;

  @override
  void dispose() {
    controller.dispose();
    addressNameController.dispose();
    fullAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCommon(
        title: local.new_address,
        activ: 3,
        onPressed: () => context.pop(),
      ),
      body: AddressMapWidget(
        controller: controller,
        addressNameController: addressNameController,
        fullAddressController: fullAddressController,
        isDefault: isDefault,
        onDefaultChanged: (val) {
          setState(() => isDefault = val);
        },
      ),
    );
  }
}
