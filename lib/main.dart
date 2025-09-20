import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/utils/themes.dart';
import 'package:screens/data/repositories/reviews_repositories.dart';
import 'package:screens/features/common/managers/like_cubit.dart';

import 'core/dependencies.dart';
import 'core/router/router.dart';
import 'data/repositories/auth_repostories.dart';
import 'data/repositories/categories_repositories.dart';
import 'data/repositories/forgot_password_repositories.dart';
import 'data/repositories/notifications_repositories.dart';
import 'data/repositories/product_repositories.dart';
import 'data/repositories/user_repositories.dart';
import 'features/common/managers/app_theme_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themes = AppThemes();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      child: MultiProvider(
        providers: dependencies,
        builder: (context, child) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AuthRepository(client: context.read(), secureStorage: context.read()),
            ),
            RepositoryProvider(create: (context) => ForgotPasswordRepository(client: context.read())),
            RepositoryProvider(create: (context) => CategoriesRepositoriy(client: context.read())),
            RepositoryProvider(create: (context) => ProductRepositories(client: context.read())),
            RepositoryProvider(create: (context) => UserRepositories(client: context.read())),
            RepositoryProvider(create: (context) => NotificationsRepositories(client: context.read())),
            RepositoryProvider(create: (context) => ReviewsRepositories(client: context.read())),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LikeCubit(userRepo: context.read())),
            ],
            child: MaterialApp.router(
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
