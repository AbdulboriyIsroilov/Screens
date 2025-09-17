import 'package:flutter/material.dart';

import '../../../data/models/auth_models/login_model.dart';
import '../../../data/repositories/auth_repostories.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required AuthRepository loginRepo,
  }) : _loginRepo = loginRepo;

  final AuthRepository _loginRepo;
  bool isLoading = true;
  String token = "";
  String? errorMessage;

  void fetchLogin({
    required LoginModel authModel,
    required VoidCallback onError,
    required VoidCallback onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();

    final data = await _loginRepo.login({
      "login": authModel.login,
      "password": authModel.password,
    });

    data.fold(
      (e) {
        errorMessage = e.toString();
        onError();
      },
      (success) {
        token = success;
        onSuccess();
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
