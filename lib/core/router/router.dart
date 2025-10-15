import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routes.dart';
import 'package:screens/features/account/managers/my_bloc.dart';
import 'package:screens/features/account/pages/account_pages.dart';
import 'package:screens/features/question/managers/question_bloc.dart';
import 'package:screens/features/question/pages/f_a_qs_page.dart';
import 'package:screens/features/account/pages/my_details_page.dart';
import 'package:screens/features/address_page/managers/address_bloc.dart';
import 'package:screens/features/address_page/pages/add_new_address_page.dart';
import 'package:screens/features/address_page/pages/address_page.dart';
import 'package:screens/features/chat/pages/chat_page.dart';
import 'package:screens/features/forgot_password/pages/enter_digit_code.dart';
import 'package:screens/features/forgot_password/pages/forgot_password_page.dart';
import 'package:screens/features/forgot_password/pages/reset_password_page.dart';
import 'package:screens/features/home/pages/home_page.dart';
import 'package:screens/features/home/pages/search_page.dart';
import 'package:screens/features/login_sign_up/managers/login_cubit.dart';
import 'package:screens/features/login_sign_up/managers/sign_up_cubit.dart';
import 'package:screens/features/login_sign_up/pages/login_page.dart';
import 'package:screens/features/login_sign_up/pages/sign_up_page.dart';
import 'package:screens/features/my_cart/pages/checkout_page.dart';
import 'package:screens/features/my_cart/pages/my_cart_page.dart';
import 'package:screens/features/my_orders/managers/order_bloc.dart';
import 'package:screens/features/my_orders/pages/my_orders_page.dart';
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
import '../../features/chat/managers/chat_bloc.dart';
import '../../features/forgot_password/managers/forgot_password_cubit.dart';
import '../../features/home/managers/home_bloc.dart';
import '../../features/home/managers/home_event.dart';
import '../../features/my_cart/managers/my_cart_bloc.dart';
import '../../features/onboarding/pages/splash_page.dart';
import '../../features/saved/pages/saved_page.dart';

final router = GoRouter(
  initialLocation: Routes.splash,

  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => BlocProvider(
        create: (context) => SignUpCubit(signRepo: context.read()),
        child: SignUpPage(),
      ),
    ),
    GoRoute(
      path: Routes.login,
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
          path: Routes.forgotPassword,
          builder: (context, state) => ForgotPasswordPage(),
        ),
        GoRoute(
          path: Routes.enterDigitCode,
          builder: (context, state) => EnterDigitCode(),
        ),
        GoRoute(
          path: Routes.resetPassword,
          builder: (context, state) => ResetPasswordPage(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final categoryId = extra?["categoryId"] ?? -1;
        return BlocProvider(
          create: (context) => HomeBloc(
            categoriesRepo: context.read(),
            productRepo: context.read(),
          )..add(FetchProductsEvent(categoryId: categoryId)),
          child: HomePage(categoryId: categoryId),
        );
      },
    ),
    GoRoute(
      path: Routes.search,
      builder: (context, state) => BlocProvider(
        create: (conetext) => HomeBloc(
          categoriesRepo: context.read(),
          productRepo: context.read(),
        ),
        child: SearchPage(),
      ),
    ),

    GoRoute(
      path: Routes.saved,
      builder: (context, state) => BlocProvider(
        create: (context) => SavedBloc(savedProductRepo: context.read()),
        child: SavedPage(),
      ),
    ),
    GoRoute(
      path: Routes.account,
      builder: (context, state) => AccountPages(),
    ),
    ShellRoute(
      builder: (context, state, child) => BlocProvider(
        create: (context) => MyCartBloc(cartRepo: context.read()),
        child: child,
      ),
      routes: [
        GoRoute(
          path: Routes.cart,
          builder: (context, state) => MyCartPage(),
        ),
        ShellRoute(
          builder: (context, state, child) => BlocProvider(
            create: (context) => CardBloc(cardRepo: context.read()),
            child: child,
          ),
          routes: [
            GoRoute(
              path: Routes.card,
              builder: (context, state) => CardPage(),
            ),
            GoRoute(
              path: Routes.newCard,
              builder: (context, state) => NewCardPage(),
            ),
            ShellRoute(
              builder: (context, state, child) => BlocProvider(
                create: (context) => AddressBloc(addressRepo: context.read()),
                child: child,
              ),
              routes: [
                GoRoute(
                  path: Routes.address,
                  builder: (context, state) => AddressPage(),
                ),
                GoRoute(
                  path: Routes.addNewAddress,
                  builder: (context, state) => AddNewAddressPage(),
                ),
                ShellRoute(
                  builder: (context, state, child) => BlocProvider(
                    create: (context) => OrderBloc(orderRepo: context.read()),
                    child: child,
                  ),
                  routes: [
                    GoRoute(
                      path: Routes.checkout,
                      builder: (context, state) => CheckoutPage(),
                    ),
                    GoRoute(
                      path: Routes.myOrders,
                      builder: (context, state) => MyOrdersPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.notifications,
      builder: (context, state) => NotificationsPage(index: (state.extra as Map)["index"]),
    ),
    GoRoute(
      path: Routes.notificationSettings,
      builder: (context, state) => NotificationSettingsPage(),
    ),
    GoRoute(
      path: Routes.helpCenter,
      builder: (context, state) => HelpCenterPage(),
    ),
    GoRoute(
      path: Routes.chat,
      builder: (context, state) => BlocProvider(
        create: (context) => ChatBloc(),
        child: ChatPage(),
      ),
    ),
    GoRoute(
      path: Routes.faq,
      builder: (context, state) => BlocProvider(
        create: (context) => QuestionBloc(questionRepo: context.read()),
        child: FAQsPage(),
      ),
    ),
    GoRoute(
      path: Routes.myDetail,
      builder: (context, state) => BlocProvider(
        create: (context) => MyBloc(myRepo: context.read()),
        child: MyDetailsPage(),
      ),
    ),
    GoRoute(
      path: Routes.productDetail,
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
