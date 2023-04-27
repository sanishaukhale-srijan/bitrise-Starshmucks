import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ReferWidgets extends StatelessWidget {
  const ReferWidgets({Key? key, this.number, this.maintext, this.subtext})
      : super(key: key);
  final number;
  final maintext;
  final subtext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundColor: HexColor("#175244"),
            radius: 30,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              maintext,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtext,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey.shade600),
            ),
          ],
        )
      ],
    );
  }
}
