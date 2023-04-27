import 'package:flutter/material.dart';

class ResetpasswordState extends StatelessWidget {
  const ResetpasswordState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ResetpasswordInitialState extends ResetpasswordState {
  const ResetpasswordInitialState({super.key});
//check if the user exists
}

class ResetpasswordValidState extends ResetpasswordState {
  String validity = '';

  ResetpasswordValidState(this.validity, {super.key});
}

class ResetpasswordErrorState extends ResetpasswordState {
  String errormessage = '';

  ResetpasswordErrorState(this.errormessage, {super.key});
}

class ResetpasswordConfirmState extends ResetpasswordState {
  String message = '';

  ResetpasswordConfirmState(this.message, {super.key});
}
