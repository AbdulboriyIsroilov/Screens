import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screens/data/repositories/categories_repositories.dart';
import 'package:screens/data/repositories/product_repositories.dart';
import 'package:screens/features/home/managers/home_event.dart';
import 'package:screens/features/home/managers/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoriesRepositoriy _categoriesRepo;
  final ProductRepositories _productRepo;

  HomeBloc({
    required CategoriesRepositoriy categoriesRepo,
    required ProductRepositories productRepo,
  }) : _categoriesRepo = categoriesRepo,
       _productRepo = productRepo,
       super(HomeState.initial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<FetchProductsEvent>(
      _onFetchProducts,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );
    add(FetchCategoriesEvent());
    add(const FetchProductsEvent(categoryId: -1));
  }

  Future<void> _onFetchCategories(FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true, errorMessage: null));

    final result = await _categoriesRepo.getCategories();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
      (success) => emit(state.copyWith(categories: success, loading: false)),
    );
  }

  Future<void> _onFetchProducts(FetchProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loadingProduct: true, errorProduct: null));

    final result = await _productRepo.getProduct(
      (event.categoryId ?? -1) == -1
          ? {
              "Title": event.title,
              "SizeId": event.sizeId,
              "MinPrice": event.minPrice,
              "MaxPrice": event.maxPrice,
              "OrderBy": event.orderBy,
            }
          : {
              "Title": event.title,
              "CategoryId": event.categoryId,
              "SizeId": event.sizeId,
              "MinPrice": event.minPrice,
              "MaxPrice": event.maxPrice,
              "OrderBy": event.orderBy,
            },
    );

    result.fold(
      (error) => emit(state.copyWith(errorProduct: error.toString(), loadingProduct: false)),
      (success) => emit(
        state.copyWith(
          product: success,
          loadingProduct: false,
          isSellect: event.categoryId ?? -1,
        ),
      ),
    );
  }
}
