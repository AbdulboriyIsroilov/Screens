import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/cart_repositories.dart';
import 'package:screens/features/my_cart/managers/my_cart_event.dart';
import 'package:screens/features/my_cart/managers/my_cart_state.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  MyCartBloc({
    required CartRepositories cartRepo,
  }) : _cartRepo = cartRepo,
       super(MyCartState.initial()) {
    on<CartEvent>(_fetchMyCart);
    add(CartEvent());
  }

  final CartRepositories _cartRepo;

  Future<void> _fetchMyCart(CartEvent event, Emitter<MyCartState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await _cartRepo.getMyCart();
    result.fold(
          (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
          (succes) => emit(state.copyWith(mycart: succes, loading: false)),
    );
  }
}
