import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:screens/data/repositories/auth_repostories.dart';

import '../data/repositories/forgot_password_repositories.dart';
import '../features/common/managers/app_theme_view_model.dart';
import 'auth_interceptor.dart';
import 'client.dart';

final dependencies = [
  ChangeNotifierProvider(create: (context) => AppThemeViewModel()),
  Provider(create: (context) => FlutterSecureStorage()),
  Provider(create: (context) => AuthInterceptor(secureStorage: context.read())),
  Provider(
    create: (context) =>
        Dio(BaseOptions(baseUrl: "http://192.168.10.16:8888/api/v1", validateStatus: (status) => true))
          ..interceptors.add(context.read<AuthInterceptor>()),
  ),
  Provider(create: (context) => ApiClient(interceptor: context.read())),
  Provider(
    create: (context) => AuthRepository(client: context.read(), secureStorage: context.read()),
  ),
  Provider(create: (context) => ForgotPasswordRepository(client: context.read())),
];
