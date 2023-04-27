import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FaqTile extends StatelessWidget {
  const FaqTile({
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  final String title;
  final String child;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
      iconColor: HexColor("#036635"),
      collapsedIconColor: HexColor("#036635"),
      expandedAlignment: Alignment.topLeft,
      title: Text(
        title,
        style: TextStyle(color: HexColor("#036635")),
      ),
      children: [
        Text(
          child,
        )
      ],
    );
  }
}
