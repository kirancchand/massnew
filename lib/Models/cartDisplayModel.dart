// To parse this JSON data, do
//
//     final cartDisplayClass = cartDisplayClassFromJson(jsonString);

import 'dart:convert';

CartDisplayClass cartDisplayClassFromJson(String str) =>
    CartDisplayClass.fromJson(json.decode(str));

String cartDisplayClassToJson(CartDisplayClass data) =>
    json.encode(data.toJson());

class CartDisplayClass {
  CartDisplayClass({
    this.data,
  });

  Data data;

  factory CartDisplayClass.fromJson(Map<String, dynamic> json) =>
      CartDisplayClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.displayCart,
    this.cartTotal,
  });

  String success;
  List<DisplayCart> displayCart;
  String cartTotal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        displayCart: List<DisplayCart>.from(
            json["display_cart"].map((x) => DisplayCart.fromJson(x))),
        cartTotal: json["cart_total"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "display_cart": List<dynamic>.from(displayCart.map((x) => x.toJson())),
        "cart_total": cartTotal,
      };
}

class DisplayCart {
  DisplayCart({
    this.cartId,
    this.cartCId,
    this.cartCName,
    this.cartItemPrice,
    this.coursepic,
    this.coursecode,
  });

  String cartId;
  String cartCId;
  String cartCName;
  String cartItemPrice;
  String coursepic;
  String coursecode;

  factory DisplayCart.fromJson(Map<String, dynamic> json) => DisplayCart(
        cartId: json["cart_id"],
        cartCId: json["cart_c_id"],
        cartCName: json["cart_c_name"],
        cartItemPrice: json["cart_item_price"],
        coursepic: json["coursepic"],
        coursecode: json["coursecode"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "cart_c_id": cartCId,
        "cart_c_name": cartCName,
        "cart_item_price": cartItemPrice,
        "coursepic": coursepic,
        "coursecode": coursecode,
      };
}
