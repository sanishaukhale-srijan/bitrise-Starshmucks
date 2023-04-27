import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary(
      {Key? key,
      required this.text,
      required this.value,
      required this.wt,
      required this.textsize})
      : super(key: key);

  final double value;
  final String text;
  final FontWeight wt;
  final double textsize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: textsize, fontWeight: wt)),
        Text(' \$$value', style: TextStyle(fontSize: textsize, fontWeight: wt)),
      ],
    );
  }
}
