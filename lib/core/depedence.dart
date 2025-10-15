import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/single_child_widget.dart';
import 'package:screens/data/repositories/question_repositories.dart';

import '../data/repositories/address_repositories.dart';
import '../data/repositories/auth_repostories.dart';
import '../data/repositories/card_repositories.dart';
import '../data/repositories/cart_repositories.dart';
import '../data/repositories/categories_repositories.dart';
import '../data/repositories/forgot_password_repositories.dart';
import '../data/repositories/notifications_repositories.dart';
import '../data/repositories/order_repositories.dart';
import '../data/repositories/product_repositories.dart';
import '../data/repositories/reviews_repositories.dart';
import '../data/repositories/user_repositories.dart';
import '../features/common/managers/like_cubit.dart';
import '../features/my_cart/managers/my_cart_bloc.dart';
import 'auth_interceptor.dart';
import 'client.dart';

final appRepo = <SingleChildWidget>[
  RepositoryProvider(create: (_) => FlutterSecureStorage()),
  RepositoryProvider(
    create: (context) => AuthInterceptor(secureStorage: context.read()),
  ),

  RepositoryProvider(
    create: (context) => Dio(
      BaseOptions(
        baseUrl: "http://192.168.10.206:8888/api/v1",
        validateStatus: (status) => true,
      ),
    )..interceptors.add(context.read<AuthInterceptor>()),
  ),
  RepositoryProvider(create: (context) => ApiClient(interceptor: context.read())),

  RepositoryProvider(
    create: (context) => AuthRepository(
      client: context.read(),
      secureStorage: context.read(),
    ),
  ),
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
  RepositoryProvider(create: (context) => QuestionRepositories(client: context.read())),
];
final appBloc = <SingleChildWidget>[
  BlocProvider(create: (context) => LikeCubit(userRepo: context.read())),
  BlocProvider(create: (context) => MyCartBloc(cartRepo: context.read())),
];
