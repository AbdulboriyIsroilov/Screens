class AddressModel {
  final int id;
  final num lat, lng;
  final String title, fullAddress;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.title,
    required this.fullAddress,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      lat: json["lat"],
      lng: json["lng"],
      title: json["title"],
      fullAddress: json["fullAddress"],
      isDefault: json["isDefault"],
    );
  }
}
