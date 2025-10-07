import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_verify.dart';
import 'package:screens/features/forgot_password/managers/forgot_password_state.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../../data/models/forgot_password_models/reset_password_email.dart';
import '../../common/widgets/app_bar_leading.dart';
import '../../common/widgets/text_button_popular.dart';
import '../managers/forgot_password_cubit.dart';

class EnterDigitCode extends StatefulWidget {
  const EnterDigitCode({super.key});

  @override
  State<EnterDigitCode> createState() => _EnterDigitCodeState();
}

class _EnterDigitCodeState extends State<EnterDigitCode> {
  String kod = "";

  @override
  Widget build(BuildContext context) {
    bool toliq = kod.length == 4;
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarLeading(
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 14.h, 25.w, 44.h),
        child: Column(
          spacing: 24.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.enter_digit_code,
                  style: AppStyles.w500s32,
                ),
                Text(
                  "${local.edc_title} (${context.read<ForgotPasswordCubit>().state.email}).",
                  style: AppStyles.w400s16,
                  maxLines: 2,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 49.w),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (val) => setState(() => kod = val),
                autoFocus: true,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10.r),
                  fieldHeight: 50.h,
                  fieldWidth: 54.w,
                  activeColor: AppColors.grey,
                  selectedColor: AppColors.black,
                  inactiveColor: AppColors.grey,
                  activeFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                ),
                textStyle: AppStyles.w500s32,
              ),
            ),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) => Center(
                child: RichText(
                  text: TextSpan(
                    style: AppStyles.w400s14,
                    children: [
                      TextSpan(
                        text: local.email_not_received,
                        style: AppStyles.w400s14,
                      ),
                      TextSpan(
                        text: local.resend_code,
                        style: AppStyles.w500s14,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await context.read<ForgotPasswordCubit>().fetchForgotEmail(
                              passwordModel: ResetPasswordEmail(email: state.email),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) => TextButtonPopular(
                title: local.continue_button,
                onPressed: toliq
                    ? () async {
                        await context.read<ForgotPasswordCubit>().fetchForgotVerify(
                          passwordModel: ResetPasswordVerify(email: state.email, code: kod),
                        );
                        context.push(Routers.resetPassword);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
