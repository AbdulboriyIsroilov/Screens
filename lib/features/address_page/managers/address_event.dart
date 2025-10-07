import 'package:screens/data/models/address_models/add_new_address_model.dart';

sealed class AddressEvent {}

final class AddressListEvent extends AddressEvent {}

final class SelectAddressEvent extends AddressEvent {
  final int selectedIndex;

  SelectAddressEvent(this.selectedIndex);
}

final class AddNewAddressEvent extends AddressEvent {
  final AddNewAddressModel data;

  AddNewAddressEvent(this.data);
}
