import 'package:equatable/equatable.dart';
import 'package:screens/data/models/card_models/card_model.dart';

class CardState extends Equatable {
  final String? errorMessage;
  final bool loading;
  final List<CardModel> card;
  final int? selectedCardId; // 🔥 tanlangan card id

  const CardState({
    required this.errorMessage,
    required this.loading,
    required this.card,
    this.selectedCardId,
  });

  factory CardState.initial() {
    return const CardState(
      errorMessage: null,
      loading: true,
      card: [],
      selectedCardId: null,
    );
  }

  CardState copyWith({
    String? errorMessage,
    bool? loading,
    List<CardModel>? card,
    int? selectedCardId,
  }) {
    return CardState(
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
      card: card ?? this.card,
      selectedCardId: selectedCardId ?? this.selectedCardId,
    );
  }

  @override
  List<Object?> get props => [errorMessage, loading, card, selectedCardId];
}
