import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screens/data/repositories/cart_repositories.dart';
import 'package:screens/features/my_cart/managers/my_cart_event.dart';
import 'package:screens/features/my_cart/managers/my_cart_state.dart';

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  MyCartBloc({
    required CartRepositories cartRepo,
  }) : _cartRepo = cartRepo,
       super(MyCartState.initial()) {
    on<CartEvent>(_fetchMyCart);
    on<CartDeleteEvent>(_fetchCartDelete);
    on<CartAddEvent>(_fetchCartAdd,transformer: (events,mapper)=>events.throttleTime(Duration(seconds: 2)).switchMap(mapper));

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

  Future<void> _fetchCartDelete(CartDeleteEvent event, Emitter<MyCartState> emit) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    var result = await _cartRepo.deleteMyCartDelate(id: event.id);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
      (success) {
        add(CartEvent());
      },
    );
  }

  Future<void> _fetchCartAdd(CartAddEvent event, Emitter<MyCartState> emit) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    var result = await _cartRepo.postCartAdd(event.data);
    result.fold(
          (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
          (success) {
        add(CartEvent());
      },
    );
  }
}
