import 'package:flutter/material.dart';

class ForgotpasswordState extends StatelessWidget {
  const ForgotpasswordState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ForgotpasswordInitialState extends ForgotpasswordState {
  const ForgotpasswordInitialState({super.key});
//check if the user exists
}

class ForgotpasswordValidState extends ForgotpasswordState {
  String validity = '';

  ForgotpasswordValidState(this.validity, {super.key});
}

class ForgotpasswordErrorState extends ForgotpasswordState {
  String errormessage = '';

  ForgotpasswordErrorState(this.errormessage, {super.key});
}
