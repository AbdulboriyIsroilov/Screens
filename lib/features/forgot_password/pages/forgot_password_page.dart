import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_email.dart';
import 'package:screens/features/common/widgets/app_bar_leading.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';
import 'package:screens/features/forgot_password/managers/forgot_password_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool emailValid = false;

  void _updateState(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Forgot password",
                  style: AppStyles.w500s32,
                ),
                Text(
                  "Enter your email for the verification process. We will send 4 digits code to your email.",
                  style: AppStyles.w400s16,
                  maxLines: 2,
                ),
              ],
            ),
            Form(
              key: formKey,
              child: TextFieldNotPasword(
                controller: emailController,
                title: "Email",
                hint: "Forgot email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _updateState(() => emailValid = false);
                    return "Email should not be empty";
                  }
                  _updateState(() => emailValid = true);
                  return null;
                },
                succes: emailValid,
              ),
            ),
            Spacer(),
            TextButtonPopular(
              title: "Send Code",
              onPressed: emailValid
                  ? () async {
                await context.read<ForgotPasswordCubit>().fetchForgotEmail(
                  passwordModel: ResetPasswordEmail(email: emailController.text),
                );
                context.push(Routers.enterDigitCode);
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
