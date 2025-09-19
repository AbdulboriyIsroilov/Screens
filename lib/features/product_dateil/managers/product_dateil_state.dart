import 'package:equatable/equatable.dart';

import '../../../data/models/product_models/product_detail_model.dart';

class ProductDetailState extends Equatable {
  final String? errorMessage;
  final bool loading;
  final ProductDetailModel detail;

  const ProductDetailState({
    required this.errorMessage,
    required this.loading,
    required this.detail,
  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
      errorMessage: null,
      loading: false,
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
    );
  }

  ProductDetailState copyWith({
    String? errorMessage,
    bool? loading,
    ProductDetailModel? detail,
  }) =>
      ProductDetailState(
        errorMessage: errorMessage ?? this.errorMessage,
        loading: loading ?? this.loading,
        detail: detail ?? this.detail,
      );

  @override
  List<Object?> get props => [errorMessage, loading, detail];
}
