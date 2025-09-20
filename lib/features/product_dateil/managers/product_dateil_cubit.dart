import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/product_repositories.dart';
import 'package:screens/data/repositories/reviews_repositories.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_state.dart';

class ProductDateilCubit extends Cubit<ProductDetailState> {
  ProductDateilCubit({
    required ProductRepositories productRepo,
    required ReviewsRepositories reviewsRepo,
    required int id,
  }) : _productRepo = productRepo,
       _reviewsRepo = reviewsRepo,
       super(ProductDetailState.initial()) {
    fetchProductDetail(id: id);
    fetchReviews(id: id);
  }

  final ProductRepositories _productRepo;
  final ReviewsRepositories _reviewsRepo;

  Future<void> fetchProductDetail({required int id}) async {
    emit(state.copyWith(loading: true));
    var result = await _productRepo.getProductDetail(id: id);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
      (succes) => emit(state.copyWith(detail: succes, loading: false)),
    );
  }

  Future<void> fetchReviews({required int id}) async {
    emit(state.copyWith(revLoading: true));
    var result = await _reviewsRepo.getReviews(id: id);
    result.fold(
      (error) => emit(state.copyWith(errorReviews: error.toString(), revLoading: false)),
      (succes) => emit(state.copyWith(reviews: succes, revLoading: false)),
    );
  }
}
