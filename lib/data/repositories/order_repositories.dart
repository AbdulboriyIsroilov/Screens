import 'package:screens/core/client.dart';
import 'package:screens/data/models/my_order_models/my_orders_model.dart';

import '../../core/utils/result.dart';

class OrderRepositories {
  OrderRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<List<MyOrdersModel>>> getOrders() async {
    var response = await _client.get<List>("/orders/list");
    return response.fold(
      (error) => Result.error(error),
      (value) => Result.ok(value.map((item) => MyOrdersModel.fromJson(item)).toList()),
    );
  }
}
