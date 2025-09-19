import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/forgot_password_models/reset_password_email.dart';
import '../../../data/models/forgot_password_models/reset_password_reset.dart';
import '../../../data/models/forgot_password_models/reset_password_verify.dart';
import '../../../data/repositories/forgot_password_repositories.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required ForgotPasswordRepository forgotRepo,
  }) : _forgotRepo = forgotRepo,
       super(ForgotPasswordState.initial());
  final ForgotPasswordRepository _forgotRepo;

  Future<void> fetchForgotEmail({
    required ResetPasswordEmail passwordModel,
  }) async {
    emit(state.copyWith(isLoadingEmail: true));
    final data = await _forgotRepo.forgotEmail(data: passwordModel);
    emit(state.copyWith(email: passwordModel.email));
    data.fold(
      (e) => emit(state.copyWith(errorEmail: e.toString())),
      (success) => emit(state.copyWith(isLoadingEmail: false)),
    );
  }

  Future<void> fetchForgotVerify({
    required ResetPasswordVerify passwordModel,
  }) async {
    emit(state.copyWith(isLoadingVerify: true));
    final data = await _forgotRepo.forgotCode(data: passwordModel);
    emit(state.copyWith(code: passwordModel.code));

    data.fold(
      (e) => emit(state.copyWith(errorVerify: e.toString())),
      (success) => emit(state.copyWith(isLoadingVerify: false)),
    );
  }

  Future<void> fetchForgotReset({
    required ResetPassword passwordModel,
  }) async {
    emit(state.copyWith(isLoadingReset: true));
    final data = await _forgotRepo.forgotReset(data: passwordModel);
    data.fold(
      (e) => emit(state.copyWith(errorReset: e.toString())),
      (success) => emit(state.copyWith(isLoadingReset: false)),
    );
  }
}
