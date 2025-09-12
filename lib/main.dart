import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:screens/core/utils/themes.dart';

import 'core/dependencies.dart';
import 'core/router/router.dart';
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
        builder: (context, child) => MaterialApp.router(
          theme: themes.lightTheme,
          darkTheme: themes.darkTheme,
          themeMode: context.watch<AppThemeViewModel>().mode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
