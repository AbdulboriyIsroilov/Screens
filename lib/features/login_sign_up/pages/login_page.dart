import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/auth_models/login_model.dart';
import 'package:screens/features/common/widgets/icon_button_popular.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';
import 'package:screens/features/login_sign_up/managers/login_view_model.dart';

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
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(loginRepo: context.read()),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: true,
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
                  Text("Login to your account", style: AppStyles.w500s32),
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
                      controller: loginController,
                      title: "Email",
                      hint: "Enter your email address",
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
                      title: "Password",
                      hint: "Enter your password",
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
                        text: "Forgot your password? ",
                        style: AppStyles.w400s14,
                      ),
                      TextSpan(
                        text: "Reset your password",
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
              Consumer<LoginViewModel>(
                builder: (context, vm, child) => TextButtonPopular(
                  title: "Login",
                  onPressed: emailValid && passwordValid
                      ? () {
                          vm.fetchLogin(
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
      ),
    );
  }
}
