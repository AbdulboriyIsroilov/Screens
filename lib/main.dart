import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/utils/themes.dart';
import 'package:screens/data/repositories/product_repositories.dart';

import 'core/dependencies.dart';
import 'core/router/router.dart';
import 'data/repositories/categories_repostories.dart';
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
            RepositoryProvider(create: (context) => CategoriesRepositoriy(client: context.read())),
            RepositoryProvider(create: (context) => ProductRepositories(client: context.read())),
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
    );
  }
}
