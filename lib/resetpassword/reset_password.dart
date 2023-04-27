import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/user_db.dart';
import '../model/user_model.dart';
import 'bloc/resetpassword_bloc.dart';
import 'bloc/resetpassword_event.dart';
import 'bloc/resetpassword_state.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late int reset0;
  late UserDB udb;
  bool reset = false;
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  List<Map<String, dynamic>> userddt = [];

  gete0() async {
    final keypref = await SharedPreferences.getInstance();
    reset0 = keypref.getInt('reset0')!;
    setState(() {});
    return reset0;
  }

  @override
  void initState() {
    udb = UserDB();
    udb.initUserDB();
    getUser();
    gete0();
    super.initState();
  }

  getUser() async {
    userddt = await udb.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 30, left: 0),
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: HexColor("#036635"),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  label: const Text(''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 48),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Reset Password',
                    style: TextStyle(
                      color: HexColor("#036635"),
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 28,
                  ),
                ),
              ),
              Divider(
                color: HexColor("#036635"),
                height: MediaQuery.of(context).size.height * 0.015,
                thickness: MediaQuery.of(context).size.height * 0.004,
                indent: MediaQuery.of(context).size.width * 0.126,
                endIndent: MediaQuery.of(context).size.width * 0.69,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 300,
                child: reset
                    ? AutoSizeText(
                        'Successfully Reset, Redirecting to Sign in in 5 seconds.',
                        style: TextStyle(
                          color: HexColor("#175244"),
                        ),
                      )
                    : AutoSizeText(
                        'Let\'s rest your password.',
                        style: TextStyle(
                          color: HexColor("#175244"),
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                builder: (context, state) {
                  //checking if There's an error in Loginstate
                  if (state is ResetpasswordErrorState) {
                    return Text(
                      state.errormessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  //if the login is valid
                  else if (state is ResetpasswordValidState) {
                    return Text(
                      state.validity,
                      style: TextStyle(
                        color: HexColor("#036635"),
                      ),
                    );
                  } else if (state is ResetpasswordConfirmState) {
                    return Text(
                      state.message,
                      style: TextStyle(
                        color: HexColor("#036635"),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                builder: (context, state) {
                  if (state is ResetpasswordConfirmState) {
                    return Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: CircularProgressIndicator(
                        color: HexColor("#036635"),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: TextFormField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                            controller: passwordcontroller,
                            onChanged: (value) {
                              BlocProvider.of<ResetpasswordBloc>(context).add(
                                PasswordChangedEvent(
                                  passwordcontroller.text,
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'New Password',
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
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.005,
                          ),
                          child: TextFormField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                            controller: confirmpasswordcontroller,
                            onChanged: (value) {
                              BlocProvider.of<ResetpasswordBloc>(context).add(
                                ConfirmpasswordChangedEvent(
                                    passwordcontroller.text,
                                    confirmpasswordcontroller.text),
                              );
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Confirm New Password',
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
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              var updateData = UserModel(
                                  tier: userddt[0]['tier'],
                                  dob: userddt[0]['dob'],
                                  email: userddt[0]['email'],
                                  phone: userddt[0]['phone'],
                                  name: userddt[0]['name'],
                                  password: passwordcontroller.text,
                                  rewards: userddt[0]['rewards'],
                                  tnc: userddt[0]['tnc'],
                                  image: userddt[0]['image']);
                              udb.updateUser(userddt[0]['id'], updateData);
                              setState(() {});

                              reset = true;
                              setState(() {});
                              BlocProvider.of<ResetpasswordBloc>(context)
                                  .add(ResetpasswordSubmittedEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              backgroundColor: HexColor("#036635"),
                            ),
                            child: const Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
