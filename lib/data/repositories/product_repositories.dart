import 'package:screens/core/client.dart';
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
}
