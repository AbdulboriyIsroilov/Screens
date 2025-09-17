import 'package:screens/core/client.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_email.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_reset.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_verify.dart';

import '../../core/utils/result.dart';

class ForgotPasswordRepository {
  ForgotPasswordRepository({
    required ApiClient client,
  }) : _client = client;

  final ApiClient _client;

  Future<Result<String>> forgotEmail({required ResetPasswordEmail data}) async {
    var reseponse = await _client.post("/auth/reset-password/email", data: data.toJson());
    return reseponse.fold(
      (error) => Result.error(error),
      (success) => Result.ok(success),
    );
  }

  Future<Result<bool>> forgotCode({required ResetPasswordVerify data}) async {
    var reseponse = await _client.post("/auth/reset-password/verify", data: data.toJson());
    return reseponse.fold(
      (error) => Result.error(error),
      (success) => Result.ok(true),
    );
  }

  Future<Result<Map<String,dynamic>>> forgotReset({required ResetPassword data}) async {
    var reseponse = await _client.post("/auth/reset-password/reset", data: data.toJson());
    return reseponse.fold(
          (error) => Result.error(error),
          (success) => Result.ok(success),
    );
  }
}
