class ResetPasswordEmail {
  final String email;

  ResetPasswordEmail({required this.email});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
