import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/order_history.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  final List<OrderHistoryModel> orderData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: HexColor("#175244")),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.date_range_outlined,
              size: 20.0,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "${orderData[0].date}",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}
