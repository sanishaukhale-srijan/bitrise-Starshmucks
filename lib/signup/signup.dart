import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '/database/user_db.dart';
import '/signup/bloc/signup_bloc.dart';
import '/signup/bloc/signup_events.dart';
import '/signup/widgets/back_button_widget.dart';
import '/signup/widgets/text_input.dart';
import '../model/user_model.dart';
import '../signin/signin.dart';
import 'bloc/signup_states.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;
  final name = TextEditingController();
  final dob = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  late UserDB udb;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return HexColor("#036635");
  }

  @override
  void initState() {
    udb = UserDB();
    udb.initUserDB();
    dob.text = "";
    super.initState();
  }

  Future<bool> getToSignin() async {
    return (await Get.to(() => const SigninPage())) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: getToSignin,
      child: Scaffold(
        appBar: null,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                BackButtonW(ctx: context),
                getlogo(context),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 46,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Sign up.',
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
                  indent: MediaQuery.of(context).size.width * 0.119,
                  endIndent: MediaQuery.of(context).size.width * 0.746,
                ),
                const SizedBox(height: 10),

                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    //checking if There's an error in Loginstate
                    if (state is SignupErrorState) {
                      return Text(
                        state.errormessage,
                        style: TextStyle(color: HexColor("#175244")),
                      );
                    }
                    //if the login is valid
                    else if (state is SignupValidState) {
                      return Text(
                        state.message,
                        style: TextStyle(color: HexColor("#175244")),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),

                //Name
                TextInputWidget(
                  lbltxt: "Name",
                  cntroller: name,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter name";
                    } else if (value.length < 3) {
                      BlocProvider.of<SignupBloc>(context)
                          .emit(SignupErrorState("What do we call you"));
                      return "Please enter 3 character for name";
                    } else {
                      BlocProvider.of<SignupBloc>(context)
                          .emit(const SignupNoErrorState());
                      return null;
                    }
                  },
                  onchange: null,
                  obstxt: false,
                ),
                //Date of Birth
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: dob,
                      //editing controller of this TextField
                      onChanged: (value) {
                        if (dob.text == '') {
                          BlocProvider.of<SignupBloc>(context).emit(
                              SignupErrorState("You might get a free drink!"));
                        } else {
                          BlocProvider.of<SignupBloc>(context)
                              .emit(const SignupNoErrorState());
                        }
                      },
                      decoration: InputDecoration(
                        //label text of field
                        contentPadding: const EdgeInsets.all(5),
                        labelText: 'Date Of Birth',
                        labelStyle: TextStyle(
                          color: HexColor("#175244"),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month_rounded,
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
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                            1900,
                            1,
                            1,
                          ),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(
                            () {
                              dob.text =
                                  formattedDate; //set output date to TextField value.
                            },
                          );
                        } else {}
                      },
                    ),
                  ),
                ),
                //Email
                TextInputWidget(
                  lbltxt: "Email",
                  cntroller: email,
                  onchange: (value) {},
                  validator: (value) {
                    if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)) {
                      BlocProvider.of<SignupBloc>(context)
                          .emit(const SignupNoErrorState());
                      return null;
                    } else {
                      BlocProvider.of<SignupBloc>(context).emit(
                          SignupErrorState("Stay updated with our newsletter"));
                      return "Please Enter a valid email";
                    }
                  },
                  obstxt: false,
                ),
                //Phone Number
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      phone.text == ""
                          ? BlocProvider.of<SignupBloc>(context).emit(
                              SignupErrorState(
                                  "We'll keep you updated via texts"))
                          : BlocProvider.of<SignupBloc>(context)
                              .emit(const SignupNoErrorState());
                    },
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
                  ),
                ),
                //Password
                TextInputWidget(
                  lbltxt: "Password",
                  cntroller: pass1,
                  onchange: (value) {},
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (!regex.hasMatch(value!)) {
                      return """* Minimum 1 Upper case\n* Minimum 1 lowercase\n* Minimum 1 Numeric Number\n* Minimum 1 Special Character\n* Common Allow Character ( ! @ # \$ & * ~ )""";
                    } else {
                      BlocProvider.of<SignupBloc>(context)
                          .emit(const SignupNoErrorState());
                      return null;
                    }
                  },
                  obstxt: true,
                ),
                //Confirm Password
                TextInputWidget(
                  lbltxt: "Confirm Password",
                  cntroller: pass2,
                  onchange: (value) {},
                  validator: (value) {
                    if (value == null) return "Enter the password";
                    if (value != pass1.text) return "Password doesn't match";
                  },
                  obstxt: true,
                ),
                //CheckBox
                Container(
                  transform: Matrix4.translationValues(30, 0, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        focusColor: Colors.green,
                        value: isChecked,
                        onChanged: (bool? value) {
                          isChecked = !isChecked;
                          isChecked == true
                              ? BlocProvider.of<SignupBloc>(context)
                                  .emit(const SignupNoErrorState())
                              : BlocProvider.of<SignupBloc>(context).emit(
                                  SignupErrorState(
                                      "Please read before you agree "));
                          setState(() {});
                        },
                      ),
                      AutoSizeText(
                        'T&C, I agree.',
                        style: TextStyle(
                          color: HexColor("#175244"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isChecked) {
                        BlocProvider.of<SignupBloc>(context)
                            .emit(SignupValidState("All Set"));
                        var userSQL = UserModel(
                          tier: "bronze",
                          name: name.text,
                          email: email.text,
                          phone: phone.text,
                          dob: dob.text,
                          password: pass1.text,
                          tnc: true.toString(),
                          rewards: 0,
                          image: '',
                        );
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupSumittedEvent(userSQL),
                        );
                      } else {
                        return BlocProvider.of<SignupBloc>(context).emit(
                            SignupErrorState("Please fill out all the fields"));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      backgroundColor: HexColor("#036635"),
                    ),
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
