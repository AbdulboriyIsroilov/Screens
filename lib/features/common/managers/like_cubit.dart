import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/features/common/managers/like_state.dart';

import '../../../data/repositories/user_repositories.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit({
    required UserRepositories userRepo,
  }) : _userRepo = userRepo,
       super(LikeState.initial());
  final UserRepositories _userRepo;

  void saveLike({required int id}) async {
    var data = await _userRepo.postSave(id: id);
    data.fold(
          (error) => emit(state.copyWith(errorSave: error.toString())),
          (succes) => null,
    );
  }

  void unsaveLike({required int id}) async {
    var data = await _userRepo.postUnsave(id: id);
    data.fold(
          (error) => emit(state.copyWith(errorUnsave: error.toString())),
          (succes) => null,
    );
  }
}
