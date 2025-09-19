import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/product_repositories.dart';
import 'package:screens/features/product_dateil/managers/product_dateil_state.dart';

class ProductDateilCubit extends Cubit<ProductDetailState> {
  ProductDateilCubit({
    required ProductRepositories productRepo,
    required int id,
  }) : _productRepo = productRepo,
       super(ProductDetailState.initial()){
    fetchProductDetail(id: id);
  }

  final ProductRepositories _productRepo;

  Future<void> fetchProductDetail({required int id})async{
    emit(state.copyWith(loading: true));
    var result = await _productRepo.getProductDetail(id: id);
    result.fold(
          (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
          (succes) => emit(state.copyWith(detail: succes, loading: false)),
    );
  }
}
