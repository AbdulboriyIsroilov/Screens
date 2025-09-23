import 'package:screens/core/client.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/cart_models/my_cart_model.dart';

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
}
