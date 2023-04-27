import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberWidget extends StatelessWidget {
  PhoneNumberWidget({super.key, this.phone, this.context});

  final phone;
  final context;
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 80,
      child: InternationalPhoneNumberInput(
        selectorConfig: const SelectorConfig(
            trailingSpace: false,
            selectorType: PhoneInputSelectorType.DROPDOWN),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        errorMessage: "Enter Valid Phone Number",
        selectorTextStyle: TextStyle(color: HexColor("#175244")),
        initialValue: number,
        textFieldController: phone,
        inputDecoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          labelText: 'Phone Number',
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
        keyboardType: TextInputType.number,
        onInputChanged: (PhoneNumber value) {},
      ),
    );
  }
}
