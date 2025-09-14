class ResetPasswordVerify {
  final String email, code;

  ResetPasswordVerify({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "code": code,
    };
  }
}
