import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/features/login_sign_up/pages/sign_up_page.dart';
import 'package:screens/features/onboarding/pages/onboarding_page.dart';

import '../../features/onboarding/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: Routers.signUp,

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
  ],
);
