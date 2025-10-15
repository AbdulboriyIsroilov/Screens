import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screens/core/depedence.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/app_localizations.dart';
import 'core/router/router.dart';
import 'core/utils/themes.dart';
import 'features/common/managers/app_theme_cubit.dart';
import 'features/common/managers/localizatoin_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.requestPermission();
  // final token = await FirebaseMessaging.instance.getToken();

  final prefs = SharedPreferencesAsync();
  final locale = await prefs.getString("locale") ?? "en";

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationCubit(locale: locale)),
        BlocProvider(create: (_) => AppThemeCubit()),
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
      builder: (context, _) {
        return MultiRepositoryProvider(
          providers: appRepo,
          child: MultiBlocProvider(
            providers: appBloc,
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
