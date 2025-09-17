import 'package:flutter/material.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_email.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_reset.dart';
import 'package:screens/data/models/forgot_password_models/reset_password_verify.dart';

import '../../../data/repositories/forgot_password_repositories.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordViewModel({
    required ForgotPasswordRepository forgotRepo,
  }) : _forgotRepo = forgotRepo;

  final ForgotPasswordRepository _forgotRepo;
  bool isLoadingEmail = true,isLoadingVerify = true,isLoadingReset = true;
  String? errorMessage;
  String email = "", code = "";

  Future<void> fetchForgotEmail({
    required ResetPasswordEmail passwordModel,
  }) async {
    isLoadingEmail = true;
    notifyListeners();

    final data = await _forgotRepo.forgotEmail(data: passwordModel);
    email = passwordModel.email;
    data.fold(
      (e) {
        errorMessage = e.toString();
      },
      (success) => Result.ok(success),
    );
    isLoadingEmail = false;
    notifyListeners();
  }

  Future<void> fetchForgotVerify({
    required ResetPasswordVerify passwordModel,
  }) async {
    isLoadingVerify = true;
    notifyListeners();

    final data = await _forgotRepo.forgotCode(data: passwordModel);
    code = passwordModel.code;
    data.fold(
      (e) {
        errorMessage = e.toString();
      },
      (success) => Result.ok(success),
    );
    isLoadingVerify = false;
    notifyListeners();
  }

  Future<void> fetchForgotReset({
    required ResetPassword passwordModel,
  }) async {
    isLoadingReset = true;
    notifyListeners();

    final data = await _forgotRepo.forgotReset(data: passwordModel);
    data.fold(
          (e) {
        errorMessage = e.toString();
      },
          (success) => Result.ok(success),
    );
    isLoadingReset = false;
    notifyListeners();
  }
}
