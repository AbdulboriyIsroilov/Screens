import 'package:screens/core/client.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/categories_models/categories_model.dart';

class CategoriesRepositoriy {
  CategoriesRepositoriy({
    required ApiClient client,
  }) : _client = client;

  final ApiClient _client;

  Future<Result<List<CategoriesModel>>> getCategories() async {
    var response = await _client.get<List>("/categories/list");
    return response.fold(

      (error) => Result.error(error),
      (value) => Result.ok(value.map((item)=> CategoriesModel.fromJson(item)).toList()),
    );
  }

}
