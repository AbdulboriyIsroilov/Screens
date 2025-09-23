import 'package:screens/core/client.dart';
import 'package:screens/data/models/product_models/product_detail_model.dart';
import 'package:screens/data/models/product_models/product_model.dart';

import '../../core/utils/result.dart';

class ProductRepositories {
  ProductRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<List<ProductModel>>> getProduct(Map<String, dynamic> queryParams) async {
    var response = await _client.get<List>("/products/list",queryParams: queryParams);
    return response.fold(
          (error) => Result.error(error),
          (value) => Result.ok(value.map((item)=> ProductModel.fromJson(item)).toList()),
    );
  }
  
  Future<Result<ProductDetailModel>> getProductDetail({required int id})async{
    var response = await _client.get<Map<String,dynamic>>("/products/detail/$id");
    return response.fold(
          (error) => Result.error(error),
          (val) => Result.ok(ProductDetailModel.fromJson(val)),
    );
  }
  
  Future<Result<List<ProductModel>>> getSavedProduct() async {
    var response = await _client.get<List>("/products/saved-products");
    return response.fold(
          (error) => Result.error(error),
          (value) => Result.ok(value.map((item)=> ProductModel.fromJson(item)).toList()),
    );
  }
}
