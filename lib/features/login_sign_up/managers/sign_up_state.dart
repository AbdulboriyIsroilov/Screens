import 'package:equatable/equatable.dart';

class SignUpState extends Equatable{
  final String? errorMessage;
  final String token;

  const SignUpState({required this.errorMessage, required this.token});

  factory SignUpState.initial() => SignUpState(
    errorMessage: null,
    token: "",
  );

  SignUpState copyWith({
    String? errorMessage,
    String? token,
  }) => SignUpState(
    errorMessage: errorMessage ?? this.errorMessage,
    token: token ?? this.token,
  );

  @override
  List<Object?> get props => [errorMessage, token];
}
