import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/l10n/app_localizations.dart';
import 'package:screens/core/utils/themes.dart';
import 'package:screens/data/repositories/cart_repositories.dart';
import 'package:screens/data/repositories/reviews_repositories.dart';
import 'package:screens/features/common/managers/like_cubit.dart';
import 'package:screens/features/common/managers/localizatoin_cubit.dart';
import 'package:screens/features/my_cart/managers/my_cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/auth_interceptor.dart';
import 'core/client.dart';
import 'core/router/router.dart';
import 'data/repositories/auth_repostories.dart';
import 'data/repositories/categories_repositories.dart';
import 'data/repositories/forgot_password_repositories.dart';
import 'data/repositories/notifications_repositories.dart';
import 'data/repositories/product_repositories.dart';
import 'data/repositories/user_repositories.dart';
import 'features/common/managers/app_theme_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesAsync();
  final locale = await prefs.getString("locale") ?? "en";
  runApp(BlocProvider(
      create: (context)=>LocalizationCubit(locale: locale),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themes = AppThemes();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          RepositoryProvider(create: (context) => FlutterSecureStorage()),
          RepositoryProvider(create: (context) => AuthInterceptor(secureStorage: context.read())),
          RepositoryProvider(
            create: (context) =>
                Dio(BaseOptions(baseUrl: "http://192.168.10.16:8888/api/v1", validateStatus: (status) => true))
                  ..interceptors.add(context.read<AuthInterceptor>()),
          ),
          RepositoryProvider(create: (context) => ApiClient(interceptor: context.read())),
          RepositoryProvider(
            create: (context) => AuthRepository(client: context.read(), secureStorage: context.read()),
          ),
          RepositoryProvider(create: (context) => ForgotPasswordRepository(client: context.read())),
          RepositoryProvider(create: (context) => CategoriesRepositoriy(client: context.read())),
          RepositoryProvider(create: (context) => ProductRepositories(client: context.read())),
          RepositoryProvider(create: (context) => UserRepositories(client: context.read())),
          RepositoryProvider(create: (context) => NotificationsRepositories(client: context.read())),
          RepositoryProvider(create: (context) => ReviewsRepositories(client: context.read())),
          RepositoryProvider(create: (context) => CartRepositories(client: context.read())),
          BlocProvider(create: (context) => LikeCubit(userRepo: context.read())),
        ],
        child: ChangeNotifierProvider(
          create: (context) => AppThemeViewModel(),
          builder: (context, child) => BlocBuilder<LocalizationCubit,Locale>(
            builder:(context,state)=> MaterialApp.router(
              locale: state,
              localizationsDelegates: MyLocalizations.localizationsDelegates,
              supportedLocales: MyLocalizations.supportedLocales,
              theme: themes.lightTheme,
              darkTheme: themes.darkTheme,
              themeMode: context.watch<AppThemeViewModel>().mode,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}
