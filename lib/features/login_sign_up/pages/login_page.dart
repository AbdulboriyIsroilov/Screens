import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/auth_models/login_model.dart';
import 'package:screens/features/common/widgets/icon_text_button_popular.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';
import 'package:screens/features/login_sign_up/managers/login_cubit.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../common/widgets/text_field_pasword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  bool emailValid = false;
  bool passwordValid = false;

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
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
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 59.h, 25.w, 31.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(local.login_to_your_account, style: AppStyles.w500s32),
                Text(local.its_great_to_see_you_again, style: AppStyles.w400s16),
              ],
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                spacing: 16.h,
                children: [
                  // EMAIL
                  TextFieldNotPasword(
                    controller: loginController,
                    title: local.email,
                    hint: local.enter_your_email_address,
                    keyboard: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => emailValid = false);
                        return "Email should not be empty";
                      }
                      if (!value.endsWith(".com")) {
                        _updateState(() => emailValid = false);
                        return "should end with .com";
                      }
                      _updateState(() => emailValid = true);
                      return null;
                    },
                    succes: emailValid,
                  ),

                  // PASSWORD
                  TextFieldPasword(
                    controller: passwordController,
                    title: local.password,
                    hint: local.enter_your_password,
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
                ],
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  style: AppStyles.w400s14,
                  children: [
                    TextSpan(
                      text: "${local.forgot_your_password} ",
                      style: AppStyles.w400s14,
                    ),
                    TextSpan(
                      text: local.reset_your_password,
                      style: AppStyles.w500s14,

                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(Routers.forgotPassword);
                        },
                    ),
                  ],
                ),
              ),
            ),
            TextButtonPopular(
              title: local.login,
              onPressed: emailValid && passwordValid
                  ? () {
                context.read<LoginCubit>().fetchLogin(
                  authModel: LoginModel(login: loginController.text, password: passwordController.text),
                  onError: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error")));
                  },
                  onSuccess: () {
                    context.go(Routers.home);
                  },
                );
              }
                  : null,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    local.or,
                    style: AppStyles.w400s14,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
            IconTextButtonPopular(
              icon: AppSvgs.logosGoogleIcon,
              color: Colors.transparent,
              title: local.google,
              fColor: AppColors.black,
            ),
            IconTextButtonPopular(
              icon: AppSvgs.logosFacebook,
              color: AppColors.blue,
              fColor: AppColors.white,
              title: local.facebook,
            ),
            Spacer(),
            Center(
              child: RichText(
                text: TextSpan(
                  style: AppStyles.w400s14,
                  children: [
                    TextSpan(
                      text: "${local.dont_have_an_account} ",
                      style: AppStyles.w400s14,
                    ),
                    TextSpan(
                      text: local.join,
                      style: AppStyles.w500s14,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(Routers.signUp);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
