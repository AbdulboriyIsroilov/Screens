class AddNewAddressModel {
  final String nickname, fullAddress;
  final double lat, lng;
  final bool isDefault;

  AddNewAddressModel({
    required this.nickname,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      "nickname": nickname,
      "fullAddress": fullAddress,
      "lat": lat,
      "lng": lat,
      "isDefault": isDefault,
    };
  }
}
