import 'package:screens/core/client.dart';

import '../../core/utils/result.dart';

class UserRepositories {
  UserRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<void>> postSave({required int id}) async {
    var response = await _client.post("/auth/save/$id",data: null);
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }

  Future<Result<void>> postUnsave({required int id}) async {
    var response = await _client.post("/auth/unsave/$id",data: null);
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }
}
