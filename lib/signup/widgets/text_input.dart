import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.cntroller,
    required this.lbltxt,
    required this.onchange,
    this.validator,
    this.obstxt,
  }) : super(key: key);

  final TextEditingController cntroller;
  final String lbltxt;
  final onchange;
  final validator;
  final obstxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          obscureText: obstxt,
          style: const TextStyle(color: Colors.black),
          controller: cntroller,
          onChanged: onchange,
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
          validator: validator,
        ),
      ),
    );
  }
}
