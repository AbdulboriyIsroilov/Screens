import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/router/routes.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_email.dart';
import 'package:screens/features/common/widgets/app_bar_leading.dart';
import 'package:screens/features/common/widgets/text_button_popular.dart';
import 'package:screens/features/common/widgets/text_field_not_pasword.dart';
import 'package:screens/features/forgot_password/managers/forgot_password_cubit.dart';

import '../../../core/l10n/app_localizations.dart';

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
    final ThemeData theme = Theme.of(context);
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                Text(local.forgot_password, style: theme.textTheme.displayMedium),
                Text(
                  local.forgot_password_title,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                ),
              ],
            ),
            Form(
              key: formKey,
              child: TextFieldNotPasword(
                controller: emailController,
                title: local.email,
                hint: local.forgot_email,
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
              title: local.send_code,
              color: theme.colorScheme.onInverseSurface,
              border: false,
              onPressed: emailValid
                  ? () async {
                      await context.read<ForgotPasswordCubit>().fetchForgotEmail(
                        passwordModel: ResetPasswordEmail(email: emailController.text),
                      );
                      context.push(Routes.enterDigitCode);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
