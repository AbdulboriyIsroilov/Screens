import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/l10n/app_localizations.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/auth_models/sign_up_model.dart';
import 'package:screens/features/common/widgets/icon_text_button_popular.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';
import 'package:screens/features/login_sign_up/managers/sign_up_cubit.dart';
import 'package:screens/features/login_sign_up/widgets/rich_text_sign_up.dart';

import '../../../core/utils/app_colors.dart';
import '../../common/widgets/text_field_pasword.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool fullNameValid = false;
  bool emailValid = false;
  bool passwordValid = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
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
    final ThemeData theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 59.h, 25.w, 37.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(local.create_an_account, style: theme.textTheme.displayMedium),
                Text(local.lets_create_your_account, style: theme.textTheme.bodySmall),
              ],
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                spacing: 16.h,
                children: [
                  // FULL NAME
                  TextFieldNotPasword(
                    controller: fullNameController,
                    title: local.full_name,
                    hint: local.enter_your_full_name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => fullNameValid = false);
                        return "Full name should not be empty";
                      }
                      if (!value.trim().contains(" ")) {
                        _updateState(() => fullNameValid = false);
                        return "There must be a space between first name and last name";
                      }
                      _updateState(() => fullNameValid = true);
                      return null;
                    },
                    succes: fullNameValid,
                  ),
                  // EMAIL
                  TextFieldNotPasword(
                    controller: emailController,
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
            RichTextSignUp(),
            TextButtonPopular(
              title: local.create_an_account,
              color: theme.colorScheme.onInverseSurface,
              border: false,
              onPressed: fullNameValid && emailValid && passwordValid
                  ? () {
                context.read<SignUpCubit>().fetchSignUp(
                  authModel: SignUpModel(
                    fullName: fullNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                  onError: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error")));
                  },
                  onSuccess: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Success")));
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
                    color: theme.colorScheme.inversePrimary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    local.or,
                    style: AppStyles.w400s14.copyWith(color: AppColors.greyDark),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: theme.colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
            Column(
              spacing: 16,
              children: [
                IconTextButtonPopular(
                  icon: AppSvgs.logosGoogleIcon,
                  color: Colors.transparent,
                  title: local.google,
                  svgColor: false,
                  fColor: theme.colorScheme.onPrimaryFixed,
                ),
                IconTextButtonPopular(
                  icon: AppSvgs.logosFacebook,
                  color: AppColors.blue,
                  fColor: AppColors.white,
                  svgColor: false,
                  title: local.facebook,
                ),
              ],
            ),
            Spacer(),
            Center(
              child: RichText(
                text: TextSpan(
                  style: AppStyles.w400s14,
                  children: [
                    TextSpan(
                      text: "${local.already_have_an_account} ",
                      style: AppStyles.w400s14,
                    ),
                    TextSpan(
                      text: local.log_in,
                      style: AppStyles.w500s14,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(Routers.login);
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
