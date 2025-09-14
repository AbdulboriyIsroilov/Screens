class ResetPassword {
  final String email, code, password;

  ResetPassword({
    required this.email,
    required this.code,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "code": code,
      "password": password,
    };
  }
}
