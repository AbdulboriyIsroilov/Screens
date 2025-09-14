import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_reset.dart';
import 'package:screens/features/common/widgets/text_field_pasword.dart';

import '../../../core/router/routers.dart';
import '../../../core/utils/app_style.dart';
import '../../common/widgets/app_bar_leading.dart';
import '../../common/widgets/text_button_popular.dart';
import '../managers/forgot_password_view_model.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordValid = false;
  bool confirmPasswordValid = false;

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
                  "Reset Password",
                  style: AppStyles.w500s35,
                ),
                Text(
                  "Set the new password for your account so you can login and access all the features.",
                  style: AppStyles.w400s16,
                  maxLines: 2,
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                spacing: 16.h,
                children: [
                  TextFieldPasword(
                    controller: passwordController,
                    title: "Password",
                    hint: "New password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => passwordValid = false);
                        return "Password should not be empty";
                      }
                      if (value.length <= 5) {
                        _updateState(() => passwordValid = false);
                        return "Must be at least 6 characters long";
                      }
                      _updateState(() => passwordValid = true);
                      return null;
                    },
                    succes: passwordValid,
                  ),
                  TextFieldPasword(
                    controller: confirmPasswordController,
                    title: "Confirm Password",
                    hint: "Confirm password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => confirmPasswordValid = false);
                        return "Password should not be empty";
                      }
                      if (value.length <= 5) {
                        _updateState(() => confirmPasswordValid = false);
                        return "Must be at least 6 characters long";
                      }
                      _updateState(() => confirmPasswordValid = true);
                      return null;
                    },
                    succes: confirmPasswordValid,
                  ),
                ],
              ),
            ),
            Consumer<ForgotPasswordViewModel>(
              builder: (context, vm, child) => TextButtonPopular(
                title: "Send Code",
                onPressed: passwordValid && confirmPasswordValid
                    ? () async {
                        if (confirmPasswordController.text != passwordController.text) {
                          await vm.fetchForgotReset(
                            passwordModel: ResetPassword(
                              email: vm.email,
                              code: vm.code,
                              password: passwordController.text,
                            ),
                          );
                          context.push(Routers.login);
                        }
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("does not equal")));
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
