import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/app_localizations.dart';
import 'core/utils/themes.dart';
import 'core/auth_interceptor.dart';
import 'core/client.dart';
import 'core/router/router.dart';
import 'data/repositories/address_repositories.dart';
import 'data/repositories/auth_repostories.dart';
import 'data/repositories/card_repositories.dart';
import 'data/repositories/cart_repositories.dart';
import 'data/repositories/categories_repositories.dart';
import 'data/repositories/forgot_password_repositories.dart';
import 'data/repositories/notifications_repositories.dart';
import 'data/repositories/order_repositories.dart';
import 'data/repositories/product_repositories.dart';
import 'data/repositories/reviews_repositories.dart';
import 'data/repositories/user_repositories.dart';
import 'features/common/managers/app_theme_cubit.dart';
import 'features/common/managers/like_cubit.dart';
import 'features/common/managers/localizatoin_cubit.dart';
import 'features/my_cart/managers/my_cart_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.requestPermission();
  final token = await FirebaseMessaging.instance.getToken();
  // print("FCM token: $token");

  final prefs = SharedPreferencesAsync();
  final locale = await prefs.getString("locale") ?? "en";

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalizationCubit(locale: locale)),
        BlocProvider(create: (context) => AppThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themes = AppThemes();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => FlutterSecureStorage()),
            RepositoryProvider(create: (context) => AuthInterceptor(secureStorage: context.read())),
            RepositoryProvider(
              create: (context) => Dio(
                BaseOptions(
                  baseUrl: "http://192.168.10.206:8888/api/v1",
                  validateStatus: (status) => true,
                ),
              )..interceptors.add(context.read<AuthInterceptor>()),
            ),
            RepositoryProvider(create: (context) => ApiClient(interceptor: context.read())),
            RepositoryProvider(create: (context) => AuthRepository(client: context.read(), secureStorage: context.read())),
            RepositoryProvider(create: (context) => ForgotPasswordRepository(client: context.read())),
            RepositoryProvider(create: (context) => CategoriesRepositoriy(client: context.read())),
            RepositoryProvider(create: (context) => ProductRepositories(client: context.read())),
            RepositoryProvider(create: (context) => UserRepositories(client: context.read())),
            RepositoryProvider(create: (context) => NotificationsRepositories(client: context.read())),
            RepositoryProvider(create: (context) => ReviewsRepositories(client: context.read())),
            RepositoryProvider(create: (context) => CartRepositories(client: context.read())),
            RepositoryProvider(create: (context) => CardRepositories(client: context.read())),
            RepositoryProvider(create: (context) => AddressRepositories(client: context.read())),
            RepositoryProvider(create: (context) => OrderRepositories(client: context.read())),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LikeCubit(userRepo: context.read())),
              BlocProvider(create: (context) => MyCartBloc(cartRepo: context.read())),
            ],
            child: BlocBuilder<LocalizationCubit, Locale>(
              builder: (context, locale) {
                return BlocBuilder<AppThemeCubit, ThemeMode>(
                  builder: (context, mode) {
                    return MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      locale: locale,
                      localizationsDelegates: MyLocalizations.localizationsDelegates,
                      supportedLocales: MyLocalizations.supportedLocales,
                      theme: themes.lightTheme,
                      darkTheme: themes.darkTheme,
                      themeMode: mode,
                      routerConfig: router,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
