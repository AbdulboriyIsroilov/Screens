import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/features/notifications/managers/notifications_event.dart';
import 'package:screens/features/notifications/managers/notifications_state.dart';

import '../../../data/models/notifications_models/notifications_model.dart';
import '../../../data/repositories/notifications_repositories.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required NotificationsRepositories notificationsRepo,
  }) : _notificationsRepo = notificationsRepo,
       super(NotificationsState.initial()) {
    on<NotificationEvent>(_fetchNotifications);
    add(NotificationEvent());
  }

  final NotificationsRepositories _notificationsRepo;

  Future<void> _fetchNotifications(NotificationEvent event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(loading: true));

    var result = await _notificationsRepo.getNotifications();

    result.fold(
      (error) => emit(
        state.copyWith(errorMessage: error.toString(), loading: false),
      ),
      (success) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final yesterday = today.subtract(const Duration(days: 1));

        // mavjud listlarni tozalash
        List<NotificationsModel> bugun = [];
        List<NotificationsModel> kecha = [];
        List<NotificationsModel> eski = [];
        for (final notif in success) {
          final notifDate = DateTime.parse(notif.date);
          final notifDay = DateTime(notifDate.year, notifDate.month, notifDate.day);

          if (notifDay == today) {
            bugun.add(notif);
          } else if (notifDay == yesterday) {
            kecha.add(notif);
          } else {
            eski.add(notif);
          }
        }

        emit(
          state.copyWith(
            loading: false,
            errorMessage: null,
            notificationsBugun: bugun,
            notificationsKecha: kecha,
            notificationsEski: eski,
          ),
        );
      },
    );
  }
}
