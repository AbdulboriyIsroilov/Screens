import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/formatter.dart';
import 'package:screens/data/models/user_models/my_update_model.dart';
import 'package:screens/features/account/managers/my_bloc.dart';
import 'package:screens/features/account/managers/my_event.dart';
import 'package:screens/features/account/managers/my_state.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../widgets/birth_date_picker_widget.dart';
import '../widgets/gender_dropdown_widget.dart';

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({super.key});

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  DateTime? tugilganSana;
  String? gender;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tugilganSana ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        tugilganSana = picked;
      });
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBarCommon(
        title: local.my_details,
        activ: 4,
        onPressed: () {
          context.pop();
        },
      ),
      body: BlocListener<MyBloc, MyState>(
        listener: (context, state) {
          fullNameController.text = state.meDetail.fullName;
          emailController.text = state.meDetail.email;
          phoneController.text = state.meDetail.phoneNumber;
          tugilganSana = DateTime.tryParse(state.meDetail.birthDate);
          gender = state.meDetail.gender;
        },
        child: BlocBuilder<MyBloc, MyState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 25.w, 20.h),
              child: state.loading
                  ? const LoadingWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16.h,
                      children: [
                        TextFieldNotPasword(
                          controller: fullNameController,
                          title: local.full_name,
                          hint: local.enter_your_full_name,
                          succes: true,
                        ),
                        TextFieldNotPasword(
                          controller: emailController,
                          title: local.email,
                          hint: local.enter_your_email_address,
                          succes: true,
                        ),
                        BirthDatePickerWidget(
                          tugilganSana: tugilganSana,
                          onSelectDate: () => _selectDate(context),
                        ),
                        GenderDropdownWidget(
                          gender: gender,
                          onChanged: (newValue) {
                            setState(() {
                              gender = newValue;
                            });
                          },
                        ),
                        TextFieldNotPasword(
                          controller: phoneController,
                          title: local.phone_number,
                          hint: "+ 998 ## ### ## ##",
                          formatter: [phoneNumberFormatter],
                          succes: true,
                        ),
                        const Spacer(),
                        TextButtonPopular(
                          title: local.submit,
                          border: false,
                          color: theme.colorScheme.onInverseSurface,
                          onPressed: () {
                            if (tugilganSana != null && gender != null) {
                              context.read<MyBloc>().add(
                                MyUpdateEvent(
                                  MyUpdateModel(
                                    gender: gender!,
                                    fullName: fullNameController.text,
                                    email: emailController.text,
                                    phoneNumber: phoneController.text,
                                    birthDate: tugilganSana!.toIso8601String(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarMain(isActive: 4),
    );
  }
}
