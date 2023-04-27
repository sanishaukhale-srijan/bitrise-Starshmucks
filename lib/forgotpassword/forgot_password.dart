import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/forgotpassword/bloc/forgotpassword_bloc.dart';
import '/forgotpassword/bloc/forgotpassword_state.dart';
import '/resetpassword/reset_password.dart';
import '../database/user_db.dart';
import 'bloc/forgotpassword_event.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final forgotpasswordinput = TextEditingController();
  final otpinput = TextEditingController();
  bool submitValid = false;
  bool verificationflag = false;
  bool userfound = false;
  late int obtainedkey;
  late EmailAuth emailAuth;
  late UserDB udb;
  List<Map<String, dynamic>> userddt = [];

  @override
  void initState() {
    udb = UserDB();
    udb.initUserDB();
    getUser();
    super.initState();
    emailAuth = EmailAuth(sessionName: "Sample session");
  }

  getUser() async {
    userddt = await udb.getUserData();
    obtainedkey = userddt[0]['id'];
    setState(() {});
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
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: HexColor("#036635")),
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  label: const Text(''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130.0, left: 48),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Forgot Password',
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
                endIndent: MediaQuery.of(context).size.width * 0.658,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 300,
                child: AutoSizeText(
                  'Please enter your details and We\'ll send you an OTP.',
                  style: TextStyle(
                    color: HexColor("#175244"),
                  ),
                ),
              ),
              BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
                builder: (context, state) {
                  //checking if There's an error in Loginstate
                  if (state is ForgotpasswordErrorState) {
                    return Text(
                      state.errormessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  //if the login is valid
                  else if (state is ForgotpasswordValidState) {
                    return Text(
                      state.validity,
                      style: TextStyle(
                        color: HexColor("#036635"),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              submitValid
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        controller: otpinput,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Enter the Verification Code',
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
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                      ),
                      child: TextFormField(
                        autocorrect: false,
                        style: const TextStyle(color: Colors.black),
                        controller: forgotpasswordinput,
                        onChanged: (value) {
                          for (int i = 0; i < userddt.length; i++) {
                            if (userddt[i]['email'] ==
                                forgotpasswordinput.text) {
                              setState(
                                () {
                                  userfound = true;
                                },
                              );
                            }
                          }

                          BlocProvider.of<ForgotpasswordBloc>(context).add(
                            ForgotpasswordInputChangedEvent(
                              forgotpasswordinput.text,
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Email or Phone Number',
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
                  onPressed: () async {
                    final resetkey = await SharedPreferences.getInstance();
                    await resetkey.setInt('reset0', obtainedkey);
                    if (userfound) {
                      submitValid ? verify() : sendOtp();
                    } else {
                      print('nootpfor you');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    backgroundColor: HexColor("#036635"),
                  ),
                  child: submitValid
                      ? const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Reset Password',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const ResetPasswordPage());
                  },
                  child: const Text("Skip"))
            ],
          ),
        ),
      ),
    );
  }

  void verify() {
    emailAuth.validateOtp(
            recipientMail: forgotpasswordinput.value.text,
            userOtp: otpinput.value.text)
        ? verificationflag = true
        : verificationflag = false;

    verificationflag
        ? Get.to(() => const ResetPasswordPage())
        : print('wrongotp');
  }

  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
      recipientMail: forgotpasswordinput.value.text,
      otpLength: 5,
    );
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }
}
