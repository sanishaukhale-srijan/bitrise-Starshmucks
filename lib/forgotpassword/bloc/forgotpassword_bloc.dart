import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/forgotpassword/bloc/forgotpassword_event.dart';
import '/forgotpassword/bloc/forgotpassword_state.dart';
import '/resetpassword/reset_password.dart';

class ForgotpasswordBloc
    extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  ForgotpasswordBloc() : super(const ForgotpasswordInitialState()) {
    //works on login text changed
    on<ForgotpasswordInputChangedEvent>(
      (event, emit) {
//user exists
        final bool isEmailValid = EmailValidator.validate(event.inputvalue);

        if (isEmailValid) {
          emit(
            ForgotpasswordValidState("An OTP will be sent to you."),
          );
        } else {
// incorrect credentials
          emit(
            ForgotpasswordErrorState("No user found"),
          );
        }
      },
    );

    //works if login is valid
    on<ForgotpasswordSumittedEvent>(
      (event, emit) {
        if (state is ForgotpasswordValidState) {
          Get.to(() => const ResetPasswordPage());
        }
      },
    );
  }
}
