import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_reset.dart';
import 'package:screens/features/common/widgets/show_diolog_modul.dart';
import 'package:screens/features/common/widgets/text_field_pasword.dart';
import 'package:screens/features/forgot_password/managers/forgot_password_state.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';
import '../../../core/utils/app_style.dart';
import '../../common/widgets/app_bar_leading.dart';
import '../../common/widgets/text_button_popular.dart';
import '../managers/forgot_password_cubit.dart';

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
    final ThemeData theme = Theme.of(context);
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
                  local.reset_password,
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  local.reset_password_title,
                  style: theme.textTheme.bodySmall,
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
                    title: local.password,
                    hint: local.new_password,
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
                    title: local.confirm_password,
                    hint: local.confirm_password,
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
            Spacer(),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) => TextButtonPopular(
                title: local.continue_button,
                color: theme.colorScheme.onInverseSurface,
                onPressed: passwordValid && confirmPasswordValid
                    ? () async {
                        if (confirmPasswordController.text == passwordController.text) {
                          await context.read<ForgotPasswordCubit>().fetchForgotReset(
                            passwordModel: ResetPassword(
                              email: state.email,
                              code: state.code,
                              password: passwordController.text,
                            ),
                          );
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ShowDiologModul(
                                title1: local.password_changed,
                                title2: local.fp_diolog_title,
                                titleButton: local.login,
                                onPressed: () {
                                  context.go(Routers.login);
                                },
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                            ),
                          );
                        }
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
