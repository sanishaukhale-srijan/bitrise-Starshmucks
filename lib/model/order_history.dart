class OrderHistoryModel {
  late String? qty;
  late String? id;
  late String? date;
  late String? time;

  OrderHistoryModel({
    required this.qty,
    required this.id,
    required this.date,
    required this.time,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        qty: json["qty"],
        id: json["id"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toMap() => {
        "qty": qty,
        "id": id,
        "date": date,
        'time': time,
      };
}
