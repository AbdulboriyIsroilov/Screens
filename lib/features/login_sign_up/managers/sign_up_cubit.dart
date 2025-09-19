import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/features/login_sign_up/managers/sign_up_state.dart';

import '../../../data/models/auth_models/sign_up_model.dart';
import '../../../data/repositories/auth_repostories.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required AuthRepository signRepo,
  }) : _signRepo = signRepo,
       super(SignUpState.initial());
  final AuthRepository _signRepo;

  void fetchSignUp({
    required SignUpModel authModel,
    required VoidCallback onError,
    required VoidCallback onSuccess,
  }) async {
    final data = await _signRepo.register({
      "fullName":authModel.fullName,
      "email": authModel.email,
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
