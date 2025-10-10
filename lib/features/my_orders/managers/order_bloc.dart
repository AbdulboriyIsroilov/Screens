import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/order_repositories.dart';
import 'package:screens/features/my_orders/managers/order_event.dart';
import 'package:screens/features/my_orders/managers/order_state.dart';

import '../../../core/utils/enum_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required OrderRepositories orderRepo,
  }) : _orderRepo = orderRepo,
       super(OrderState.initial()){
    on<MyOrderListEvent>(_fetchOrderList);
    add(MyOrderListEvent());
  }

  final OrderRepositories _orderRepo;

  Future<void> _fetchOrderList(MyOrderListEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(orderEnum: EnumState.loading));
    final result = await _orderRepo.getOrders();

    result.fold(
      (error) => emit(
        state.copyWith(errorMessage: error.toString(), orderEnum: EnumState.error),
      ),
      (success) {
        emit(state.copyWith(address: success, orderEnum: EnumState.success));
      },
    );
  }
}
