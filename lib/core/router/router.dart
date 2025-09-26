import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/features/account/pages/account_pages.dart';
import 'package:screens/features/forgot_password/pages/enter_digit_code.dart';
import 'package:screens/features/forgot_password/pages/forgot_password_page.dart';
import 'package:screens/features/forgot_password/pages/reset_password_page.dart';
import 'package:screens/features/home/pages/home_page.dart';
import 'package:screens/features/login_sign_up/managers/login_cubit.dart';
import 'package:screens/features/login_sign_up/managers/sign_up_cubit.dart';
import 'package:screens/features/login_sign_up/pages/login_page.dart';
import 'package:screens/features/login_sign_up/pages/sign_up_page.dart';
import 'package:screens/features/my_cart/pages/my_cart_page.dart';
import 'package:screens/features/notifications/pages/notification_settings_page.dart';
import 'package:screens/features/notifications/pages/notifications_page.dart';
import 'package:screens/features/onboarding/pages/onboarding_page.dart';
import 'package:screens/features/payment_method/managers/card_bloc.dart';
import 'package:screens/features/payment_method/pages/card_page.dart';
import 'package:screens/features/payment_method/pages/new_card_page.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_cubit.dart';
import 'package:screens/features/product_dateil/pages/product_detail_page.dart';
import 'package:screens/features/saved/managers/saved_bloc.dart';

import '../../features/account/pages/help_center_page.dart';
import '../../features/forgot_password/managers/forgot_password_cubit.dart';
import '../../features/home/managers/home_cubit.dart';
import '../../features/my_cart/managers/my_cart_bloc.dart';
import '../../features/onboarding/pages/splash_page.dart';
import '../../features/saved/pages/saved_page.dart';

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
      builder: (context, state) => BlocProvider(
        create: (context) => SignUpCubit(signRepo: context.read()),
        child: SignUpPage(),
      ),
    ),
    GoRoute(
      path: Routers.login,
      builder: (context, state) => BlocProvider(
        create: (context) => LoginCubit(loginRepo: context.read()),
        child: LoginPage(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) => BlocProvider(
        create: (context) => ForgotPasswordCubit(forgotRepo: context.read()),
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
        final categoryId = extra?["categoryId"] ?? -1;
        return BlocProvider(
          create: (context) => HomeCubit(categoriesRep: context.read(), productRepo: context.read()),
          child: HomePage(categoryId: categoryId),
        );
      },
    ),
    GoRoute(
      path: Routers.saved,
      builder: (context, state) => BlocProvider(
        create: (context) => SavedBloc(savedProductRepo: context.read()),
        child: SavedPage(),
      ),
    ),
    GoRoute(
      path: Routers.account,
      builder: (context, state) => AccountPages(),
    ),
    GoRoute(
      path: Routers.cart,
      builder: (context, state) => BlocProvider(
        create: (context) => MyCartBloc(cartRepo: context.read()),
        child: MyCartPage(),
      ),
    ),

    ShellRoute(
      builder: (context, state, child) => BlocProvider(
        create: (context) => CardBloc(cardRepo: context.read()),
        child: child,
      ),
      routes: [
        GoRoute(
          path: Routers.card,
          builder: (context, state) => CardPage(),
        ),
        GoRoute(
          path: Routers.newCard,
          builder: (context, state) => NewCardPage(),
        ),
      ],
    ),
    GoRoute(
      path: Routers.notifications,
      builder: (context, state) => NotificationsPage(index: (state.extra as Map)["index"]),
    ),
    GoRoute(
      path: Routers.notificationSettings,
      builder: (context, state) => NotificationSettingsPage(),
    ),
    GoRoute(
      path: Routers.helpCenter,
      builder: (context, state) => HelpCenterPage(),
    ),
    GoRoute(
      path: Routers.productDetail,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (context) => ProductDateilCubit(productRepo: context.read(), id: id, reviewsRepo: context.read()),
          child: ProductDetailPage(),
        );
      },
    ),
  ],
);
