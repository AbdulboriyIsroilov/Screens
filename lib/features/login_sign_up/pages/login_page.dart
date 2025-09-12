import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/icon_button_popular.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';

import '../../../core/utils/app_colors.dart';
import '../../common/widgets/text_field_pasword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool fullNameValid = false;
  bool emailValid = false;
  bool passwordValid = false;

  @override
  void dispose() {
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
    return Scaffold(
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
                Text("Login to your account", style: AppStyles.w500s35),
                Text("It’s great to see you again.", style: AppStyles.w400s16),
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
                    controller: emailController,
                    title: "Email",
                    hint: "Enter your email address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => emailValid = false);
                        return "Email should not be empty";
                      }
                      if (!value.endsWith("@gmail.com")) {
                        _updateState(() => emailValid = false);
                        return "should end with @gmail.com";
                      }
                      _updateState(() => emailValid = true);
                      return null;
                    },
                    succes: emailValid,
                  ),

                  // PASSWORD
                  TextFieldPasword(
                    controller: passwordController,
                    text: "Password",
                    hint: "Enter your password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _updateState(() => passwordValid = false);
                        return "Password should not be empty";
                      }
                      if (value.length <= 6) {
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
                      text: "Forgot your password? ",
                      style: AppStyles.w400s14,
                    ),
                    TextSpan(
                      text: "Reset your password",
                      style: AppStyles.w500s14,

                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
            TextButtonPopular(
              title: "Login",
              onPressed: fullNameValid && emailValid && passwordValid ? () {} : null,
            ),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "OR",
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
            IconButtonPopular(
              icon: AppSvgs.logosGoogleIcon,
              color: Colors.transparent,
              title: "Sign Up with Google",
            ),
            IconButtonPopular(
              icon: AppSvgs.logosFacebook,
              color: AppColors.blue,
              fColor: AppColors.white,
              title: "Sign Up with Facebook",
            ),
            Spacer(),
            Center(
              child: RichText(
                text: TextSpan(
                  style: AppStyles.w400s14,
                  children: [
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: AppStyles.w400s14,
                    ),
                    TextSpan(
                      text: "Join",
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
