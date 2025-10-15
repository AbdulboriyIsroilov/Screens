import 'package:screens/core/client.dart';
import 'package:screens/data/models/address_models/add_new_address_model.dart';
import 'package:screens/data/models/address_models/addres_model.dart';

import '../../core/utils/result.dart';

class AddressRepositories {
  AddressRepositories({
    required ApiClient client,
  }) : _client = client;

  final ApiClient _client;

  Future<Result<List<AddressModel>>> getAddress() async {
    var response = await _client.get<List>("/addresses");
    return response.fold(
      (error) => Result.error(error),
      (value) => Result.ok(value.map((item) => AddressModel.fromJson(item)).toList()),
    );
  }

  Future<Result<void>> postAddress(AddNewAddressModel data) async {
    var response = await _client.post("/addresses", data: data.toJson());
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }

  Future<Result<void>> deleteAddress({required int id}) async {
    var response = await _client.delete("/addresses/$id");
    return response.fold(
          (error) => Result.error(error),
          (val) => Result.ok(null),
    );
  }
}
