// class CardModel {
//   final int id;
//   final String cardNumber;
//
//   CardModel({
//     required this.id,
//     required this.cardNumber,
//   });
//
//   factory CardModel.fromJson(Map<String, dynamic> json) {
//     return CardModel(
//       id: json["id"],
//       cardNumber: json["cardNumber"],
//     );
//   }
// }

class CardModel {
  final int id;
  final String cardNumber;
  final String cardType;   // faqat front-end logika uchun
  final bool isDefault;    // dastur ichida boshqariladi

  CardModel({
    required this.id,
    required this.cardNumber,
    this.cardType = "visa",
    this.isDefault = false,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json["id"],
      cardNumber: json["cardNumber"],
      cardType: _detectType(json["cardNumber"]), // kartadan aniqlash
    );
  }

  static String _detectType(String number) {
    if (number.startsWith("9860")) return "mastercard";
    if (number.startsWith("4")) return "visa";
    return "unknown";
  }
}

