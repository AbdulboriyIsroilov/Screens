import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/features/saved/managers/saved_event.dart';
import 'package:screens/features/saved/managers/saved_state.dart';

import '../../../data/repositories/product_repositories.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc({
    required ProductRepositories savedProductRepo,
  }) : _savedProductRepo = savedProductRepo,
       super(SavedState.initial()) {
    on<SavedProductEvent>(_fetchSavedProduct);
    add(SavedProductEvent());
  }

  final ProductRepositories _savedProductRepo;

  Future<void> _fetchSavedProduct(SavedProductEvent event, Emitter<SavedState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await _savedProductRepo.getSavedProduct();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
      (succes) => emit(state.copyWith(savedProduct: succes, loading: false)),
    );
  }
}
