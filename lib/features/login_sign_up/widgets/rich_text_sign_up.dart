import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:screens/core/utils/app_style.dart';

import '../../../core/l10n/app_localizations.dart';

class RichTextSignUp extends StatelessWidget {
  const RichTextSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14),
        children: [
          TextSpan(
            text: MyLocalizations.of(context)!.signup_text,
            style: theme.textTheme.titleSmall,
          ),
          TextSpan(
            text: "Terms",
            style: theme.textTheme.titleLarge,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: ", ", style: AppStyles.w400s14),
          TextSpan(
            text: "Privacy Policy",
            style: theme.textTheme.titleLarge,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: ", ${MyLocalizations.of(context)!.and} ", style: AppStyles.w400s14),
          TextSpan(
            text: "Cookie Use",
            style: theme.textTheme.titleLarge,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
