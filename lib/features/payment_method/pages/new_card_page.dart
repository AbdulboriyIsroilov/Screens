import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/formatter.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/data/models/card_models/add_catd_model.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';
import 'package:screens/features/payment_method/managers/card_bloc.dart';
import 'package:screens/features/payment_method/managers/card_event.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/show_diolog_modul.dart';

class NewCardPage extends StatefulWidget {
  const NewCardPage({super.key});

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  final formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final codeController = TextEditingController();

  bool emailValid = false;
  bool expiryValid = false;
  bool cvcValid = false;

  String convertExpiryDate(String input) {
    final parts = input.split('/');
    final month = parts[0];
    final year = parts[1];
    return "20$year-$month-01";
  }

  @override
  void dispose() {
    numberController.dispose();
    dateController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void _updateState(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(
        title: "New Card",
        activ: 3,
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 31.h),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            spacing: 16.h,
            children: [
              Text(local.add_debit_credit_card, style: AppStyles.w600s16),
              TextFieldNotPasword(
                controller: numberController,
                title: local.card_number,
                hint: local.enter_your_card_number,
                formatter: [cardNumberFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _updateState(() => emailValid = false);
                    return "Card number should not be empty";
                  }
                  if (value.length != 19) {
                    _updateState(() => emailValid = false);
                    return "Card number should be 16 digits.";
                  }
                  _updateState(() => emailValid = true);
                  return null;
                },
                succes: emailValid,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldNotPasword(
                    controller: dateController,
                    title: local.expiry_date,
                    hint: "MM/YY",
                    maxwidth: 165,
                    formatter: [expiryDateFormatter],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => expiryValid = false);
                        return "Expiry date should not be empty";
                      }
                      final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
                      if (!regex.hasMatch(value)) {
                        _updateState(() => expiryValid = false);
                        return "Expiry date must be in MM/YY format";
                      }
                      _updateState(() => expiryValid = true);
                      return null;
                    },
                    succes: expiryValid,
                  ),
                  TextFieldNotPasword(
                    controller: codeController,
                    title: local.security_code,
                    hint: "CVC",
                    maxwidth: 165,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => cvcValid = false);
                        return "Card number should not be empty";
                      }
                      if (value.length != 3) {
                        _updateState(() => cvcValid = false);
                        return "Code should be 3 digits.";
                      }
                      _updateState(() => cvcValid = true);
                      return null;
                    },
                    succes: cvcValid,
                  ),
                ],
              ),
              Spacer(),
              TextButtonPopular(
                title: local.add_card,
                onPressed: emailValid && expiryValid && cvcValid
                    ? () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return ShowDiologModul(
                              title1: 'Congratulations!',
                              title2: 'Your new card has been added.',
                              titleButton: 'Thanks',
                              onPressed: () {
                                context.pop();
                                context.go(Routers.card);
                              },
                            );
                          },
                        );
                        context.read<CardBloc>().add(
                          CardAddEvent(
                            AddCatdModel(
                              cardNumber: numberController.text,
                              expiryDate: convertExpiryDate(dateController.text),
                              securityCode: codeController.text,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
