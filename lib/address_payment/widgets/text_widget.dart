import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, this.lbltxt, this.context, this.txtcontroler});

  final context;
  final txtcontroler;
  final lbltxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.005,
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: txtcontroler,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          labelText: lbltxt,
          labelStyle: TextStyle(
            color: HexColor("#175244"),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: HexColor("#175244"),
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: HexColor("#175244"),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
