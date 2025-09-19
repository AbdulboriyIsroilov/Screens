import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoadingEmail, isLoadingVerify, isLoadingReset;
  final String? errorEmail, errorVerify, errorReset;
  final String email, code;

  const ForgotPasswordState({
    required this.isLoadingEmail,
    required this.isLoadingVerify,
    required this.isLoadingReset,
    required this.errorEmail,
    required this.errorVerify,
    required this.errorReset,
    required this.email,
    required this.code,
  });

  factory ForgotPasswordState.initial() => ForgotPasswordState(
    isLoadingEmail: true,
    isLoadingVerify: true,
    isLoadingReset: true,
    errorEmail: null,
    errorVerify: null,
    errorReset: null,
    email: '',
    code: '',
  );

  ForgotPasswordState copyWith({
    bool? isLoadingEmail,
    bool? isLoadingVerify,
    bool? isLoadingReset,
    String? errorEmail,
    String? errorVerify,
    String? errorReset,
    String? email,
    String? code,
  }) => ForgotPasswordState(
    isLoadingEmail: isLoadingEmail ?? this.isLoadingEmail,
    isLoadingVerify: isLoadingVerify ?? this.isLoadingVerify,
    isLoadingReset: isLoadingReset ?? this.isLoadingReset,
    errorEmail: errorEmail ?? this.errorEmail,
    errorVerify: errorVerify ?? this.errorVerify,
    errorReset: errorReset ?? this.errorReset,
    email: email ?? this.email,
    code: code ?? this.code,
  );

  @override
  List<Object?> get props => [
    isLoadingEmail,
    isLoadingVerify,
    isLoadingReset,
    errorEmail,
    errorVerify,
    errorReset,
    email,
    code,
  ];
}
