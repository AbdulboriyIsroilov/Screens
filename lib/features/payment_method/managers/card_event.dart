import '../../../data/models/card_models/add_catd_model.dart';

sealed class CardEvent {}

final class CardListEvent extends CardEvent {}

final class CardAddEvent extends CardEvent {
  final AddCatdModel data;

  CardAddEvent(this.data);
}

final class SelectCardEvent extends CardEvent {
  final int selectedId;

  SelectCardEvent(this.selectedId);
}

final class CardDeleteEvent extends CardEvent {
  final int id;

  CardDeleteEvent(this.id);
}
