import 'package:flutter/material.dart';

import '../../../data/models/auth_models/sign_up_model.dart';
import '../../../data/repositories/auth_repostoriy.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel({
    required AuthRepository signRepo,
  }) : _signRepo = signRepo;

  final AuthRepository _signRepo;
  bool isLoading = true;
  String token = "";

  void fetchSignUp({
    required SignUpModel authModel,
    required VoidCallback onError,
    required VoidCallback onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();

    final data = await _signRepo.register({
      "fullName":authModel.fullName,
      "email": authModel.email,
      "password": authModel.password,
    });
    data.fold(
      (e) {
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
