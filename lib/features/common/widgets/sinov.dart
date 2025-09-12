import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: Colors.black, // umumiy matn rangi
        ),
        children: [
          const TextSpan(text: "By signing up you agree to our "),
          TextSpan(
            text: "Terms",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Terms bosilganda
                print("Terms clicked");
              },
          ),
          const TextSpan(text: ", "),
          TextSpan(
            text: "Privacy Policy",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print("Privacy clicked");
              },
          ),
          const TextSpan(text: ", and "),
          TextSpan(
            text: "Cookie Use",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Cookie Use bosilganda
                print("Cookie clicked");
              },
          ),
        ],
      ),
    );
  }
}
