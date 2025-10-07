import 'package:flutter/material.dart';

class AddNewAddressModel {
  final String title, fullAddress;
  final double lat, lng;
  final bool isDefault;

  AddNewAddressModel({
    required this.title,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "fullAddress": fullAddress,
      "lat": lat,
      "lng": lat,
      "isDefault": isDefault,
    };
  }
}
