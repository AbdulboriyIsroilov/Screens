import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/user_repositories.dart';
import 'package:screens/features/account/managers/my_event.dart';
import 'package:screens/features/account/managers/my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc({
    required UserRepositories myRepo,
  }) : _myRepo = myRepo,
       super(MyState.initial()) {
    on<MyDetailEvent>(_fetchMeDetail);
    on<MyUpdateEvent>(_fetchMyUpdate);
    add(MyDetailEvent());
  }

  final UserRepositories _myRepo;

  Future<void> _fetchMeDetail(MyDetailEvent event, Emitter<MyState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await _myRepo.getMe();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
      (succes) => emit(state.copyWith(meDetail: succes, loading: false)),
    );
  }

  Future<void> _fetchMyUpdate(MyUpdateEvent event, Emitter<MyState> emit) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    var result = await _myRepo.postAuthUpdate(event.data);
    result.fold(
          (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
          (success) {
            emit(state.copyWith(loading: false));
        add(MyDetailEvent());
      },
    );
  }
}
