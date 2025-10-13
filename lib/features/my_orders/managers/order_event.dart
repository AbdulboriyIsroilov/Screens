import 'package:screens/data/models/my_order_models/my_orders_create_model.dart';

sealed class OrderEvent{}

final class  MyOrderListEvent extends OrderEvent{}

final class MyOrderCreateEvent extends OrderEvent {
  final MyOrdersCreateModel data;

  MyOrderCreateEvent(this.data);
}