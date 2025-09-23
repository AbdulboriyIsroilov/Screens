import 'package:equatable/equatable.dart';
import 'package:screens/data/models/cart_models/my_cart_model.dart';

class MyCartState extends Equatable {
  final String? errorMessage;
  final bool loading;
  final MyCartModel mycart;

  const MyCartState({
    required this.errorMessage,
    required this.loading,
    required this.mycart,
  });

  factory MyCartState.initial() {
    return MyCartState(
      errorMessage: null,
      loading: true,
      mycart: MyCartModel(
        items: [],
        subTotal: 0,
        vat: 0,
        shippingFee: 0,
        total: 0,
      ),
    );
  }

  MyCartState copyWith({
    String? errorMessage,
    bool? loading,
    MyCartModel? mycart,
  }) {
    return MyCartState(
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
      mycart: mycart ?? this.mycart,
    );
  }

  @override
  List<Object?> get props => [errorMessage, loading, mycart];
}
