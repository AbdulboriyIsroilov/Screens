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
    var response = await _client.get("/cart-items");
    return response.fold(
      (error) => Result.error(error),
      (val) => Result.ok(MyCartModel.fromJson(val as Map<String, dynamic>)),
    );
  }

  Future<Result<void>> deleteMyCartDelete({required int id}) async {
    var response = await _client.delete("/cart-items/$id");
    return response.fold(
      (error) => Result.error(error),
      (val) => Result.ok(null),
    );
  }

  Future<Result<void>> postCartAdd(MyCartAddModel data) async {
    var response = await _client.post("/cart-items", data: data.toJson());
    return response.fold(
      (error) => Result.error(error),
      (success) => Result.ok(null),
    );
  }

  Future<Result> patchMyCart({required int id,required int quantity}) async {
    var response = await _client.patch("/cart-items/$id", data: {"quantity":quantity});
    return response.fold(
          (error) => Result.error(error),
          (val) => Result.ok(val),
    );
  }
}
