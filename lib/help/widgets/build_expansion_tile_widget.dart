import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BuildExpansionTile extends StatelessWidget {
  const BuildExpansionTile({
    required this.img,
    required this.text,
    required this.content,
    Key? key,
  }) : super(key: key);
  final String img;
  final String text;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        elevation: 8,
        child: ExpansionTile(
          trailing: const SizedBox(width: 10),
          iconColor: HexColor("#036635"),
          collapsedIconColor: HexColor("#036635"),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 30),
            child: Row(
              children: [
                Image.asset(
                  img,
                  width: 50,
                ),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(fontSize: 20, color: HexColor("#036635")),
                ),
              ],
            ),
          ),
          children: [content],
        ),
      ),
    );
  }
}
