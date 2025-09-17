import 'package:equatable/equatable.dart';
import 'package:screens/data/models/categories_models/categories_model.dart';
import 'package:screens/data/models/product_models/product_model.dart';

class HomeState extends Equatable {
  final String? errorMessage, errorProduct;
  final bool loading, loadingProduct;
  final List<CategoriesModel> categories;
  final List<ProductModel> product;

  HomeState({
    required this.errorMessage,
    required this.errorProduct,
    required this.loading,
    required this.loadingProduct,
    required this.categories,
    required this.product,
  });

  factory HomeState.initial() => HomeState(
    errorMessage: null,
    errorProduct: null,
    loading: true,
    loadingProduct: true,
    categories: [],
    product: [],
  );

  HomeState copyWith({
    String? errorMessage,
    errorProduct,
    bool? loading,
    loadingProduct,
    List<CategoriesModel>? categories,
    List<ProductModel>? product,
  }) => HomeState(
    errorMessage: errorMessage ?? this.errorMessage,
    errorProduct: errorProduct ?? this.errorProduct,
    loading: loading ?? this.loading,
    loadingProduct: loadingProduct ?? this.loadingProduct,
    categories: categories ?? this.categories,
    product: product ?? this.product,
  );

  @override
  List<Object?> get props => [errorMessage, errorProduct, loading, loadingProduct, categories, product];
}
