import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/features/forgot_password/pages/enter_digit_code.dart';
import 'package:screens/features/forgot_password/pages/forgot_password_page.dart';
import 'package:screens/features/forgot_password/pages/reset_password_page.dart';
import 'package:screens/features/home/pages/home_page.dart';
import 'package:screens/features/login_sign_up/pages/login_page.dart';
import 'package:screens/features/login_sign_up/pages/sign_up_page.dart';
import 'package:screens/features/onboarding/pages/onboarding_page.dart';

import '../../features/forgot_password/managers/forgot_password_view_model.dart';
import '../../features/onboarding/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: Routers.splash,

  routes: <RouteBase>[
    GoRoute(
      path: Routers.splash,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: Routers.onboarding,
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      path: Routers.signUp,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: Routers.login,
      builder: (context, state) => LoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => ChangeNotifierProvider(
        create: (context) => ForgotPasswordViewModel(forgotRepo: context.read()),
        child: child,
      ),
      routes: [
        GoRoute(
          path: Routers.forgotPassword,
          builder: (context, state) => ForgotPasswordPage(),
        ),
        GoRoute(
          path: Routers.enterDigitCode,
          builder: (context, state) => EnterDigitCode(),
        ),
        GoRoute(
          path: Routers.resetPassword,
          builder: (context, state) => ResetPasswordPage(),
        ),
      ],
    ),
    GoRoute(
      path: Routers.home,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final categoryId = extra?["categoryId"] ?? 0;
        return HomePage(categoryId: categoryId);
      },
    ),

  ],
);
