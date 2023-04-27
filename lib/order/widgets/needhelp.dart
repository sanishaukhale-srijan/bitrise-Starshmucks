import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../help/help_page.dart';

class NeedHelp extends StatelessWidget {
  const NeedHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Help());
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        width: MediaQuery.of(context).size.width * 1,
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Need Help?",
                  style: TextStyle(
                      color: HexColor("#175244"), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
