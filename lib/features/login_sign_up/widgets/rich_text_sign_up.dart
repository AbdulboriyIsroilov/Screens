import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:screens/core/utils/app_style.dart';

class RichTextSignUp extends StatelessWidget {
  const RichTextSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: "By signing up you agree to our ",
            style: AppStyles.w400s14,
          ),
          TextSpan(
            text: "Terms",
            style: AppStyles.w500s14,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: ", ", style: AppStyles.w400s14),
          TextSpan(
            text: "Privacy Policy",
            style: AppStyles.w500s14,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: ", and ", style: AppStyles.w400s14),
          TextSpan(
            text: "Cookie Use",
            style: AppStyles.w500s14,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
