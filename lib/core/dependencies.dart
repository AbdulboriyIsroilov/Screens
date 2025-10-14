import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth_repostories.dart';
import '../data/repositories/categories_repositories.dart';
import '../data/repositories/forgot_password_repositories.dart';
import '../data/repositories/notifications_repositories.dart';
import '../data/repositories/product_repositories.dart';
import '../data/repositories/reviews_repositories.dart';
import '../data/repositories/user_repositories.dart';
import '../features/common/managers/app_theme_cubit.dart';
import 'auth_interceptor.dart';
import 'client.dart';

final dependencies = [
  // ChangeNotifierProvider(create: (context) => AppThemeViewModel()),
];

final repositoryProvider = [
  RepositoryProvider(create: (context) => FlutterSecureStorage()),
  RepositoryProvider(create: (context) => AuthInterceptor(secureStorage: context.read())),
  RepositoryProvider(
    create: (context) =>
    Dio(BaseOptions(baseUrl: "http://192.168.10.15:8888/api/v1", validateStatus: (status) => true))
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
];
