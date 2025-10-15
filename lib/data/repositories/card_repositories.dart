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
    var response = await _client.get<List>("/cards");
    return response.fold(
          (error) => Result.error(error),
          (value) => Result.ok(value.map((item)=> CardModel.fromJson(item)).toList()),
    );
  }

  Future<Result<void>> postCard(AddCatdModel data) async {
    var response = await _client.post("/cards", data: data.toJson());
    return response.fold(
          (error) => Result.error(error),
          (success) => Result.ok(null),
    );
  }

  Future<Result<void>> deleteCard({required int id}) async {
    var response = await _client.delete("/cards/$id");
    return response.fold(
          (error) => Result.error(error),
          (val) => Result.ok(null),
    );
  }
}
