import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/product_repositories.dart';
import 'package:screens/features/saved/managers/saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit({
    required ProductRepositories savedProductRepo,
  }) : _savedProductRepo = savedProductRepo,
       super(SavedState.initial()) {
    fetchSavedProduct();
  }

  final ProductRepositories _savedProductRepo;

  Future<void> fetchSavedProduct() async {
    emit(state.copyWith(loading: true));
    var result = await _savedProductRepo.getSavedProduct();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
      (succes) => emit(state.copyWith(savedProduct: succes, loading: false)),
    );
  }
}
