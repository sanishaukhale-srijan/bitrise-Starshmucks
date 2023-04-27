import 'package:flutter/material.dart';

class SignupState extends StatelessWidget {
  const SignupState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SignupNoErrorState extends SignupState {
  const SignupNoErrorState({super.key});
}

class SignupValidState extends SignupState {
  String message = '';

  SignupValidState(this.message, {super.key});
}

class SignupErrorState extends SignupState {
  String errormessage = '';

  SignupErrorState(this.errormessage, {super.key});
}
