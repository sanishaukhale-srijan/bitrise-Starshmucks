import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EditableField extends StatelessWidget {
  const EditableField({
    Key? key,
    required this.ncontroller,
    required this.lbltxt,
    this.vldtr, this.onchange,
  }) : super(key: key);

  final TextEditingController ncontroller;
  final String lbltxt;
  final vldtr;
  final onchange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .89,
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: ncontroller,
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
        validator: vldtr,
        onChanged: onchange,
      ),
    );
  }
}
