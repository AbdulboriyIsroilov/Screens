class MyUpdateModel {
  final String gender, fullName, email, phoneNumber, birthDate;

  MyUpdateModel({
    required this.gender,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "gender": gender,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "birthDate": birthDate,
    };
  }
}
