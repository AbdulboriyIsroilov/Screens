import 'package:screens/core/client.dart';
import 'package:screens/data/models/user_models/my_model.dart';
import 'package:screens/data/models/user_models/my_update_model.dart';

import '../../core/utils/result.dart';

class UserRepositories {
  UserRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<void>> postSave({required int id}) async {
    var response = await _client.post("/auth/save/$id", data: null);
    return response.fold(
      (error) => Result.error(error),
      (success) => Result.ok(null),
    );
  }

  Future<Result<void>> postUnsave({required int id}) async {
    var response = await _client.post("/auth/unsave/$id", data: null);
    return response.fold(
      (error) => Result.error(error),
      (success) => Result.ok(null),
    );
  }

  Future<Result<MyModel>> getMe() async {
    var response = await _client.get("/auth/me");
    return response.fold(
      (error) => Result.error(error),
      (value) => Result.ok(MyModel.fromJson(value)),
    );
  }

  Future<Result<void>> postAuthUpdate(MyUpdateModel data) async {
    var response = await _client.patch("/auth/update", data: data.toJson());
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }
}
