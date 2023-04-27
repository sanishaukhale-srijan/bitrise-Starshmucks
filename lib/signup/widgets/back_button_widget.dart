import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../signin/signin.dart';

class BackButtonW extends StatelessWidget {
  const BackButtonW({
    Key? key,
    this.ctx,
  }) : super(key: key);
  final ctx;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 0),
      alignment: Alignment.topLeft,
      child: TextButton.icon(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: HexColor("#036635"),
        ),
        onPressed: () {
          Get.to(() => const SigninPage());
        },
        label: const Text(''),
      ),
    );
  }
}
