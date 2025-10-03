import 'package:screens/data/models/user_models/my_update_model.dart';

sealed class MyEvent {}

final class MyDetailEvent extends MyEvent {}

final class MyUpdateEvent extends MyEvent {
  final MyUpdateModel data;

  MyUpdateEvent(this.data);
}
