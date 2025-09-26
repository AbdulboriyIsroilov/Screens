import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/onboarding/widgets/onboarding_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 59.h),
        child: Stack(
          children: [
            Image.asset(
              "assets/image/onboarding_line.png",
              color: Colors.grey,
              width: double.infinity,
              height: 745.h,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 42.w),
              child: SizedBox(
                width: 324.w,
                height: 204.h,
                child: Text(
                  local.onboarding,
                  style: AppStyles.w600s64,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "assets/image/onboarding.png",
                width: 358.w,
                height: 640.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 22.h, 25.w, 31.h),
        child: OnboardingButton(
          onPressed: () {
            context.go(Routers.signUp);
          },
          title: 'Get Started',
        ),
      ),
    );
  }
}
