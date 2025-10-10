import 'package:equatable/equatable.dart';
import 'package:screens/data/models/my_order_models/my_orders_model.dart';
import '../../../core/utils/enum_state.dart';

class OrderState extends Equatable {
  final String? errorMessage;
  final List<MyOrdersModel> orders;
  final EnumState orderEnum;

  const OrderState({
    required this.errorMessage,
    required this.orders,
    required this.orderEnum,
  });

  factory OrderState.initial() => const OrderState(
    errorMessage: null,
    orders: [],
    orderEnum: EnumState.initial,
  );

  OrderState copyWith({
    String? errorMessage,
    List<MyOrdersModel>? address,
    EnumState? orderEnum,
  }) {
    return OrderState(
      errorMessage: errorMessage ?? this.errorMessage,
      orders: address ?? this.orders,
      orderEnum: orderEnum ?? this.orderEnum,
    );
  }

  @override
  List<Object?> get props => [errorMessage, orders, orderEnum];
}
