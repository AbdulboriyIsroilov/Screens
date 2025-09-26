import 'package:screens/core/client.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/card_models/card_model.dart';

import '../models/card_models/add_catd_model.dart';

class CardRepositories {
  CardRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<List<CardModel>>> getCards()async{
    var response = await _client.get<List>("/cards/list");
    return response.fold(
          (error) => Result.error(error),
          (value) => Result.ok(value.map((item)=> CardModel.fromJson(item)).toList()),
    );
  }

  Future<Result<void>> postCardAdd(AddCatdModel data) async {
    var response = await _client.post("/cards/create", data: data.toJson());
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }
}
