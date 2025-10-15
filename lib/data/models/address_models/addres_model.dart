class AddressModel {
  final int id;
  final String nickname, fullAddress;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.nickname,
    required this.fullAddress,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      nickname: json["nickname"],
      fullAddress: json["fullAddress"],
      isDefault: json["isDefault"],
    );
  }
}
