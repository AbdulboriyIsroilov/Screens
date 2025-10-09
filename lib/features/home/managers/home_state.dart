import 'package:equatable/equatable.dart';
import 'package:screens/data/models/categories_models/categories_model.dart';
import 'package:screens/data/models/product_models/product_model.dart';

class HomeState extends Equatable {
  final String? errorMessage, errorProduct, errorSave, errorUnsave;
  final bool loading, loadingProduct;
  final int isSellect;
  final List<CategoriesModel> categories;
  final List<ProductModel> product;

  const HomeState({
    required this.errorMessage,
    required this.errorProduct,
    required this.errorSave,
    required this.errorUnsave,
    required this.loading,
    required this.loadingProduct,
    required this.isSellect,
    required this.categories,
    required this.product,
  });

  factory HomeState.initial() => HomeState(
    errorMessage: null,
    errorProduct: null,
    errorSave: null,
    errorUnsave: null,
    loading: true,
    loadingProduct: true,
    isSellect: -1,
    categories: [],
    product: [],
  );

  HomeState copyWith({
    String? errorMessage,
    String? errorProduct,
    String? errorSave,
    String? errorUnsave,
    bool? loading,
    bool? loadingProduct,
    int? isSellect,
    List<CategoriesModel>? categories,
    List<ProductModel>? product,
  }) =>
      HomeState(
        errorMessage: errorMessage ?? this.errorMessage,
        errorProduct: errorProduct ?? this.errorProduct,
        errorSave: errorSave ?? this.errorSave,
        errorUnsave: errorUnsave ?? this.errorUnsave,
        loading: loading ?? this.loading,
        loadingProduct: loadingProduct ?? this.loadingProduct,
        isSellect: isSellect ?? this.isSellect,
        categories: categories ?? this.categories,
        product: product ?? this.product,
      );

  @override
  List<Object?> get props => [
    errorMessage,
    errorProduct,
    errorSave,
    errorUnsave,
    loading,
    loadingProduct,
    isSellect,
    categories,
    product,
  ];
}
