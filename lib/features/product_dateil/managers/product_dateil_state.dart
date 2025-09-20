import 'package:equatable/equatable.dart';
import 'package:screens/data/models/reviews_models/reviews_model.dart';

import '../../../data/models/product_models/product_detail_model.dart';

class ProductDetailState extends Equatable {
  final String? errorMessage, errorReviews;
  final bool loading, revLoading;
  final ProductDetailModel detail;
  final List<ReviewsModel> reviews;

  const ProductDetailState({
    required this.errorMessage,
    required this.errorReviews,
    required this.loading,
    required this.revLoading,
    required this.detail,
    required this.reviews,
  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
      errorMessage: null,
      errorReviews: null,
      loading: false,
      revLoading: false,
      detail: ProductDetailModel(
        id: 0,
        title: "",
        description: "",
        price: 0,
        isLiked: false,
        productImages: [],
        productSizes: [],
        reviewsCount: 0,
        rating: 0.0,
      ),
      reviews: [],
    );
  }

  ProductDetailState copyWith({
    String? errorMessage,
    String? errorReviews,
    bool? loading,
    bool? revLoading,
    ProductDetailModel? detail,
    List<ReviewsModel>? reviews,
  }) => ProductDetailState(
    errorMessage: errorMessage ?? this.errorMessage,
    errorReviews: errorReviews ?? this.errorReviews,
    loading: loading ?? this.loading,
    revLoading: revLoading ?? this.revLoading,
    detail: detail ?? this.detail,
    reviews: reviews ?? this.reviews,
  );

  @override
  List<Object?> get props => [errorMessage, errorReviews, loading, revLoading, detail, reviews];
}
