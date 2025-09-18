import 'package:equatable/equatable.dart';
import 'package:screens/data/models/notifications_models/notifications_model.dart';

class NotificationsState extends Equatable {
  final String? errorMessage;
  final bool loading;
  final List<NotificationsModel> notificationsBugun, notificationsKecha, notificationsEski;

  const NotificationsState({
    required this.errorMessage,
    required this.loading,
    required this.notificationsBugun,
    required this.notificationsKecha,
    required this.notificationsEski,
  });

  factory NotificationsState.initial() => NotificationsState(
    errorMessage: null,
    loading: true,
    notificationsBugun: [],
    notificationsKecha: [],
    notificationsEski: [],
  );

  NotificationsState copyWith({
    String? errorMessage,
    bool? loading,
    List<NotificationsModel>? notificationsBugun,
    List<NotificationsModel>? notificationsKecha,
    List<NotificationsModel>? notificationsEski,
  }) => NotificationsState(
    errorMessage: errorMessage ?? this.errorMessage,
    loading: loading ?? this.loading,
    notificationsBugun: notificationsBugun ?? this.notificationsBugun,
    notificationsKecha: notificationsKecha ?? this.notificationsKecha,
    notificationsEski: notificationsEski ?? this.notificationsEski,
  );

  @override
  List<Object?> get props => [errorMessage, loading, notificationsBugun, notificationsKecha, notificationsEski];
}
