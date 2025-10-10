import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/data/repositories/address_repositories.dart';
import 'package:screens/features/address_page/managers/address_event.dart';
import 'package:screens/features/address_page/managers/address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepositories _addressRepo;

  AddressBloc({
    required AddressRepositories addressRepo,
  }) : _addressRepo = addressRepo,
       super(AddressState.initial()) {
    on<AddressListEvent>(_fetchAddressList);
    on<SelectAddressEvent>(_selectAddress);
    on<AddNewAddressEvent>(_fetchNewAddress);
    add(AddressListEvent());
  }

  Future<void> _fetchAddressList(AddressListEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(addressEnum: EnumState.loading));
    final result = await _addressRepo.getAddress();

    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), addressEnum: EnumState.error)),
      (success) {
        int? defaultIndex = success.indexWhere((element) => element.isDefault == true);
        if (defaultIndex == -1) defaultIndex = null;

        emit(
          state.copyWith(address: success, addressEnum: EnumState.success, selectedIndex: defaultIndex),
        );
      },
    );
  }

  void _selectAddress(SelectAddressEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  Future<void> _fetchNewAddress(AddNewAddressEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(newAddress: EnumState.loading, errorMessage: null));
    var result = await _addressRepo.postNewAddress(event.data);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), newAddress: EnumState.error)),
      (success) => emit(state.copyWith(newAddress: EnumState.success)),
    );
  }
}
