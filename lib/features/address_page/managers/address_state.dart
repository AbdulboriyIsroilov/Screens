import 'package:equatable/equatable.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/data/models/address_models/addres_model.dart';

class AddressState extends Equatable {
  final String? errorMessage;
  final List<AddressModel> address;
  final EnumState addressEnum, newAddress;
  final int? selectedIndex; // ✅ tanlangan manzil index

  const AddressState({
    required this.errorMessage,
    required this.address,
    required this.addressEnum,
    required this.selectedIndex,
    required this.newAddress,
  });

  factory AddressState.initial() => const AddressState(
    errorMessage: null,
    address: [],
    addressEnum: EnumState.initial,
    selectedIndex: null,
    newAddress: EnumState.initial,
  );

  AddressState copyWith({
    String? errorMessage,
    List<AddressModel>? address,
    EnumState? addressEnum,
    int? selectedIndex,
    EnumState? newAddress,
  }) {
    return AddressState(
      errorMessage: errorMessage ?? this.errorMessage,
      address: address ?? this.address,
      addressEnum: addressEnum ?? this.addressEnum,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      newAddress: newAddress ?? this.newAddress,
    );
  }

  @override
  List<Object?> get props => [errorMessage, address, addressEnum, selectedIndex,newAddress];
}
