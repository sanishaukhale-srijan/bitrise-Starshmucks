import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/signin/signin.dart';
import 'resetpassword_event.dart';
import 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  ResetpasswordBloc() : super(const ResetpasswordInitialState()) {
    //works on login text changed
    on<PasswordChangedEvent>(
      (event, emit) {
        if (event.newpassword.trim().isEmpty) {
          emit(
            ResetpasswordErrorState("Please enter a password"),
          );
        } else if (event.newpassword.trim().length < 4) {
          emit(ResetpasswordErrorState(
              "Your password must be at least 4 Characters"));
        }
        // Return null if the entered username is valid
        else {
          emit(
            ResetpasswordValidState('Done! Now let\'s confirm your password'),
          );
        }
      },
    );
    on<ConfirmpasswordChangedEvent>(
      (event, emit) {
        if (event.confirmpassword.trim().isEmpty) {
          emit(ResetpasswordErrorState("Please confirm your password"));
        } else if (event.confirmpassword.trim().length < 4) {
          emit(ResetpasswordErrorState(
              "Your confirm password must be at least 4 Characters"));
        } else if (event.confirmpassword != event.newpassword) {
          emit(ResetpasswordErrorState(
              "Your password and confirm password should match"));
        }
        // Return null if the entered username is valid
        else {
          emit(ResetpasswordValidState('All Set!'));
        }
      },
    );

    //works if login is valid
    on<ResetpasswordSubmittedEvent>(
      (event, emit) {
        emit(ResetpasswordConfirmState(''));
        if (state is ResetpasswordConfirmState) {
          emit(ResetpasswordConfirmState(''));
          Future.delayed(
            const Duration(seconds: 5),
            () {
              Get.to(() => const SigninPage());
            },
          );
        } else {
          return null;
        }
      },
    );
  }
}
