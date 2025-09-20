import 'package:screens/core/client.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/reviews_models/reviews_model.dart';

class ReviewsRepositories {
  ReviewsRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<List<ReviewsModel>>> getReviews({required int id}) async {
    var response = await _client.get<List>("/reviews/list/$id");
    return response.fold(
      (error) => Result.error(error),
      (val) => Result.ok(val.map((item) => ReviewsModel.fromJson(item)).toList()),
    );
  }
}
