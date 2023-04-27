class WishlistModel {
  int id;

  WishlistModel({
    required this.id,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
