import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/features/login_sign_up/managers/login_state.dart';

import '../../../data/models/auth_models/login_model.dart';
import '../../../data/repositories/auth_repostories.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthRepository loginRepo,
  }) : _loginRepo = loginRepo,
       super(LoginState.initial());
  final AuthRepository _loginRepo;

  void fetchLogin({
    required LoginModel authModel,
    required VoidCallback onError,
    required VoidCallback onSuccess,
  }) async {
    final data = await _loginRepo.login({
      "login": authModel.login,
      "password": authModel.password,
    });

    data.fold(
      (e) {
        emit(state.copyWith(errorMessage: e.toString()));
        onError();
      },
      (success) {
        emit(state.copyWith(token: success));
        onSuccess();
      },
    );
  }
}
