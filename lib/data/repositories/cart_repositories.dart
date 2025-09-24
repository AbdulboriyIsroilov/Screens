import 'package:screens/core/client.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/cart_models/my_cart_model.dart';

import '../models/cart_models/my_cart_add_model.dart';

class CartRepositories {
  CartRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<MyCartModel>> getMyCart() async {
    var response = await _client.get("/my-cart/my-cart-items");
    return response.fold(
      (error) => Result.error(error),
      (val) => Result.ok(MyCartModel.fromJson(val as Map<String, dynamic>)),
    );
  }

  Future<Result<void>> deleteMyCartDelate({required int id}) async {
    var response = await _client.delete("/my-cart/delete/$id");
    return response.fold(
      (error) => Result.error(error),
      (val) => Result.ok(null),
    );
  }

  Future<Result<void>> postCartAdd(MyCartAddModel data) async {
    var response = await _client.post("/my-cart/add-item", data: data.toJson());
    return response.fold(
      (error) => Result.error(error),
      (success) => Result.ok(null),
    );
  }
}
