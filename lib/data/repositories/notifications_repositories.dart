import 'package:screens/core/client.dart';
import 'package:screens/core/utils/result.dart';
import 'package:screens/data/models/notifications_models/notifications_model.dart';

class NotificationsRepositories {
  NotificationsRepositories({
    required ApiClient client,
  }) : _client = client;
  final ApiClient _client;

  Future<Result<List<NotificationsModel>>> getNotifications() async {
    var response = await _client.get<List>("/notifications/list");
    return response.fold(
      (error) => Result.error(error),
      (value) => Result.ok(value.map((item) => NotificationsModel.fromJson(item)).toList()),
    );
  }
}
