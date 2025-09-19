import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? errorMessage;
  final String token;

  const LoginState({required this.errorMessage, required this.token});

  factory LoginState.initial() => LoginState(
    errorMessage: null,
    token: "",
  );

  LoginState copyWith({
    String? errorMessage,
    String? token,
  }) => LoginState(
    errorMessage: errorMessage ?? this.errorMessage,
    token: token ?? this.token,
  );

  @override
  List<Object?> get props => [errorMessage, token];
}
