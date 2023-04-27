class CartModel {
  int id;
  int qty;

  CartModel({
    required this.id,
    required this.qty,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        qty: json["qty"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "qty": qty,
      };
}
