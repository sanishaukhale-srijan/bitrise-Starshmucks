// ignore_for_file: void_checks
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starshmucks/database/user_db.dart';

import '../../model/user_model.dart';
import 'editdetails_events.dart';
import 'editdetails_states.dart';

class EditdetailsBloc extends Bloc<EditdetailsEvent, EditdetailsState> {
  EditdetailsBloc() : super(const EditdetailsInitialState()) {
    List<Map<String, dynamic>> usernames = [];

    //works on login text changed
    on<EditdetailsemailChangedEvent>((event, emit) {
      print("event triggered");
      if (event.emailvalue != '') {
        emit(EditdetailsValidState("all good"));
      } else if (event.emailvalue == '' || event.emailvalue.trim().length < 4) {
        emit(
          EditdetailsErrorState("Please enter a valid Email"),
        );
      } else {
        return emit(EditdetailsValidState(""));
      }
    });
    on<EditdetailsNameChangedEvent>((event, emit) {
//user exists
      if (event.namevalue == '' || event.namevalue.trim().length < 4) {
        emit(
          EditdetailsErrorState("Please enter a valid Name"),
        );
      } else {
        return emit(EditdetailsValidState(""));
      }
    });
    on<EditdetailsNumberChangedEvent>(
      (event, emit) {
        if (event.phnvalue.trim().isEmpty){
          emit(
            EditdetailsErrorState("Please enter your phone number"),
          );
        } else if (event.phnvalue.trim().length < 4) {
          emit(
            EditdetailsErrorState(
                "Your phone number must be at least 4 digits"),
          );
        }
        // Return null if the entered username is valid
        else {
          return emit(EditdetailsValidState(""));
        }
      },
    );
    //works if login is valid
    on<EditdetailsSumittedEvent>(
      (event, emit) async{
        UserDB udb = UserDB();
        usernames = await udb.getUserData();
        if (state is EditdetailsValidState){

          var updateData = UserModel(
              tier: usernames[0]['tier'],
              dob: usernames[0]['dob'],
              email: event.email,
              phone: event.phnvalue,
              name:event.namevalue,
              password: usernames[0]['password'],
              rewards: usernames[0]['rewards'],
              tnc: usernames[0]['tnc'],
              image: usernames[0]['image']);
          udb.updateUser(usernames[0]['id'], updateData);
        }
      },
    );
  }
}
