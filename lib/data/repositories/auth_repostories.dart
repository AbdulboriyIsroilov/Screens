import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/client.dart';
import '../../core/router/router.dart';
import '../../core/router/routes.dart';
import '../../core/utils/result.dart';

class AuthRepository {
  final ApiClient _client;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({
    required ApiClient client,
    required FlutterSecureStorage secureStorage,
  }) : _client = client,
       _secureStorage = secureStorage;

  Future<Result<String>> login(Map<String, dynamic> data) async {
    var response = await _client.post("/auth/login", data: data);
    return response.fold(
      (error) => Result.error(error),
      (success) {
        _secureStorage.write(key: "token", value: success["accessToken"]);
        _secureStorage.write(key: "login", value: data["login"]);
        _secureStorage.write(key: "password", value: data["password"]);
        return Result.ok(success["accessToken"]);
      },
    );
  }

  Future<Result<String>> register(Map<String, dynamic> data) async {
    var reseponse = await _client.post("/auth/register", data: data);
    return reseponse.fold(
      (error) {
        return Result.error(error);
      },
      (success) {
        _secureStorage.write(key: "token", value: success["accessToken"]);
        _secureStorage.write(key: "login", value: data["login"]);
        _secureStorage.write(key: "password", value: data["password"]);
        return Result.ok(success["accessToken"]);
      },
    );
  }

  Future<void> logout() async {
    _secureStorage.delete(key: "token");
    _secureStorage.delete(key: "login");
    _secureStorage.delete(key: "password");
    router.go(Routes.login);
  }
}
