class MyCartModel {
  List<CartItem> items;
  int subTotal;
  int vat;
  int shippingFee;
  int total;

  MyCartModel({
    required this.items,
    required this.subTotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
  });

  factory MyCartModel.fromJson(Map<String, dynamic> json) {
    return MyCartModel(
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      subTotal: json['subTotal'],
      vat: json['vat'],
      shippingFee: json['shippingFee'],
      total: json['total'],
    );
  }
}

class CartItem {
  int id;
  int productId;
  String title;
  String size;
  int price;
  String image;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.size,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      size: json['size'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}
