import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/categories_repostories.dart';
import 'package:screens/data/repositories/product_repositories.dart';
import 'package:screens/features/home/managers/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required CategoriesRepositoriy categoriesRep,
    required ProductRepositories productRepo,
  }) : _categoriesRepo = categoriesRep,
       _productRepo = productRepo,
       super(HomeState.initial()) {
    fetchCategories();
    fetchProduct();
  }

  final CategoriesRepositoriy _categoriesRepo;
  final ProductRepositories _productRepo;

  Future<void> fetchCategories() async {
    emit(state.copyWith(loading: true, errorMessage: null));

    var result = await _categoriesRepo.getCategories();
    result.fold(
      (error) => emit(
        state.copyWith(errorMessage: error.toString(), loading: false),
      ),
      (success) => emit(
        state.copyWith(categories: success, loading: false),
      ),
    );
  }

  Future<void> fetchProduct() async {
    emit(state.copyWith(loadingProduct: true, errorProduct: null));

    var result = await _productRepo.getProduct({});
    result.fold(
      (error) => emit(
        state.copyWith(errorProduct: error.toString(), loadingProduct: false),
      ),
      (success) => emit(
        state.copyWith(product: success, loadingProduct: false),
      ),
    );
  }
}
