import '../../../data/models/cart_models/my_cart_add_model.dart';

sealed class MyCartEvent {}

final class CartEvent extends MyCartEvent {}

final class CartDeleteEvent extends MyCartEvent {
  final int id;
  CartDeleteEvent(this.id);
}

final class CartAddEvent extends MyCartEvent {
  final MyCartAddModel data;
  CartAddEvent(this.data);
}
