import 'package:equatable/equatable.dart';

class LikeState extends Equatable {
  final String? errorSave, errorUnsave;

  const LikeState({required this.errorSave, required this.errorUnsave});

  factory LikeState.initial() => LikeState(
    errorSave: null,
    errorUnsave: null,
  );

  LikeState copyWith({
    String? errorSave,
    String? errorUnsave,
  }) => LikeState(
    errorSave: errorSave ?? this.errorSave,
    errorUnsave: errorUnsave ?? this.errorUnsave,
  );

  @override
  List<Object?> get props => [errorSave,errorUnsave];
}
