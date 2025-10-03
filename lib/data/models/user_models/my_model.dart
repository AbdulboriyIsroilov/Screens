class MyModel {
  final int id;
  final String fullName, email, phoneNumber, gender, birthDate;

  MyModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  });

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      gender: json["gender"],
      birthDate: json["birthDate"],
    );
  }
}
