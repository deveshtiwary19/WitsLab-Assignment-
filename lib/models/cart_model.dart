// To parse this JSON data, do
//
//     final Cart = CartFromJson(jsonString);

import 'dart:convert';

List<Cart> CartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String CartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  int id;
  double price;
  String title;
  bool selected;
  int qty;
  String image;

  Cart({
    required this.id,
    required this.price,
    required this.title,
    required this.selected,
    required this.qty,
    required this.image,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        price: json["price"]?.toDouble(),
        title: json["title"],
        selected: json["selected"],
        qty: json["qty"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "title": title,
        "selected": selected,
        "qty": qty,
        "image": image,
      };
}
