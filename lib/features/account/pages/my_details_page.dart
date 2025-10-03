import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/formatter.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(local.date_of_birth, style: AppStyles.w500s16),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tugilganSana == null
                                    ? local.select_date
                                    : "${tugilganSana!.day.toString().padLeft(2, '0')}/"
                                    "${tugilganSana!.month.toString().padLeft(2, '0')}/"
                                    "${tugilganSana!.year}",
                                style: AppStyles.w500s16,
                              ),
                              SvgPicture.asset(AppSvgs.calendar),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(local.gender, style: AppStyles.w500s16),
                      DropdownButtonFormField<String>(
                        value: gender,
                        hint: Text(local.select_gender),
                        items: ["Male", "Female"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 14.sp)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            gender = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                        ),
                      ),
                    ],
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
