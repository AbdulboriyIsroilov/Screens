import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/data/repositories/card_repositories.dart';
import 'package:screens/features/payment_method/managers/card_event.dart';
import 'package:screens/features/payment_method/managers/card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc({
    required CardRepositories cardRepo,
  })  : _cardRepo = cardRepo,
        super(CardState.initial()) {
    on<CardListEvent>(_fetchCardList);
    on<CardAddEvent>(_fetchCardAdd);
    on<SelectCardEvent>(_onSelectCard);
    add(CardListEvent());
  }

  final CardRepositories _cardRepo;

  Future<void> _fetchCardList(CardListEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await _cardRepo.getCards();
    result.fold(
          (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
          (success) => emit(
        state.copyWith(
          card: success,
          loading: false,
          selectedCardId: success.isNotEmpty ? success.first.id : null,
        ),
      ),
    );
  }

  Future<void> _fetchCardAdd(CardAddEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    var result = await _cardRepo.postCardAdd(event.data);
    result.fold(
          (error) => emit(state.copyWith(errorMessage: error.toString(), loading: false)),
          (success) {
        add(CardListEvent());
      },
    );
  }

  void _onSelectCard(SelectCardEvent event, Emitter<CardState> emit) {
    emit(state.copyWith(selectedCardId: event.selectedId));
  }
}
