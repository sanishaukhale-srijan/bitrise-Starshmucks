import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, this.color, this.progress, this.tier})
      : super(key: key);
  final progress;
  final tier;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width * 0.26,
      child: LinearProgressIndicator(
        // color: Colors.white,
        backgroundColor: HexColor("#175244"),
        valueColor: AlwaysStoppedAnimation<Color>(
            tier == 'gold' ? Colors.amberAccent : color),
        value: progress,
      ),
    );
  }
}
