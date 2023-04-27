import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starshmucks/editdetails/bloc/editdetails_events.dart';

import '/editdetails/widgets/editable_field_widget.dart';
import '/model/user_model.dart';
import '../common_things.dart';
import '../database/user_db.dart';
import 'bloc/editdetails_bloc.dart';
import 'bloc/editdetails_states.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final picker = ImagePicker();

class _EditProfileState extends State<EditProfile> {
  File? imagefile;
  String saveImage = '';
  final ImagePicker picker = ImagePicker();
  late String obtainedemail;
  late String obtainedphone;
  late String obtainedname;
  late int obtainedkey;
  late TextEditingController econtroller;
  late TextEditingController ncontroller;
  late TextEditingController phcontroller;
  late UserDB udb;

  List<Map<String, dynamic>> usernames = [];

  getUser() async {
    usernames = await udb.getUserData();

      econtroller = TextEditingController(text: usernames[0]['email']);
      ncontroller = TextEditingController(text: usernames[0]['name']);
      phcontroller = TextEditingController(text: usernames[0]['phone']);

    setState(() {});
  }

  @override
  void initState() {
    udb = UserDB();
    udb.initUserDB();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: getHomeAppBar("Edit Profile", [Container()], true, 0.0),
        backgroundColor: HexColor("#175244"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => showSelectionDialog());
                },
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: usernames[0]['image'] == ''
                            ? const DecorationImage(
                                image: AssetImage('images/profile1.jpg'),
                              )
                            : DecorationImage(
                                image: FileImage(File(usernames[0]['image'])),
                                fit: BoxFit.cover,
                              ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(75.0),
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 4.0,
                        ),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(60, 150, 0),
                      child: const Icon(Icons.add_a_photo, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Align(
                     alignment: Alignment.center,
                     child: Text(
                       usernames[0]['name'],
                       style: const TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 35,
                       ),
                     ),
                   ),


              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    BlocBuilder<EditdetailsBloc, EditdetailsState>(
                      builder: (context, state) {
                        if (state is EditdetailsErrorState) {
                          return Text(
                            state.errormessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    //name
                    EditableField(
                      onchange: (value){
                        BlocProvider.of<EditdetailsBloc>(context).add(EditdetailsNameChangedEvent(ncontroller.text));
                      },
                      ncontroller: ncontroller,
                      lbltxt: 'Name',
                      vldtr: (value) {
                        if (value == null) {
                          return "Please enter name";
                        } else if (value.length < 3) {
                          return "Please enter 3 character for name";
                        } else {
                          return null;
                        }
                      },

                    ),
                    const SizedBox(height: 10),
                    //email
                    EditableField(
                      onchange: (value){
                        BlocProvider.of<EditdetailsBloc>(context).add(EditdetailsemailChangedEvent(econtroller.text));
                      },
                      ncontroller: econtroller,
                      lbltxt: 'Email',
                      vldtr: (value) {

                        if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return null;
                        } else {
                          return "Please Enter a valid email";
                        }

                      },
                    ),
                    const SizedBox(height: 10),
                    //phone
                    EditableField(
                      onchange: (value){
                        BlocProvider.of<EditdetailsBloc>(context).add(EditdetailsNumberChangedEvent(phcontroller.text));
                      },
                      ncontroller: phcontroller,
                      lbltxt: 'Phone',
                      vldtr: null,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          HexColor("#175244"),
                        ),
                      ),
                      onPressed: () async {
                        BlocProvider.of<EditdetailsBloc>(context).add(EditdetailsSumittedEvent(econtroller.text, ncontroller.text, phcontroller.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: HexColor("#175244"),
                            content: const Text(
                              'Details Updated',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                        getUser();
                      },
                      child: const Text('UPDATE'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  }

  showSelectionDialog() {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              takepicture(ImageSource.camera);
            },
            icon: Icon(Icons.camera_alt_outlined, color: HexColor("#175244")),
            label: Text(
              'Click a picture now',
              style: TextStyle(color: HexColor("#175244")),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              takepicture(ImageSource.gallery);
            },
            icon: Icon(Icons.image, color: HexColor("#175244")),
            label: Text(
              'Choose from gallery',
              style: TextStyle(color: HexColor("#175244")),
            ),
          )
        ],
      ),
    );
  }

  takepicture(ImageSource source) async {
    final pickedfile = await picker.pickImage(source: source);
    imagefile = File(pickedfile!.path);
    saveImage = pickedfile.path;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to save the picture?"),
          actions: [
            TextButton(
              onPressed: () {
                var updateData = UserModel(
                    tier: usernames[0]['tier'],
                    dob: usernames[0]['dob'],
                    email: econtroller.text,
                    phone: phcontroller.text,
                    name: ncontroller.text,
                    password: usernames[0]['password'],
                    rewards: usernames[0]['rewards'],
                    tnc: usernames[0]['tnc'],
                    image: saveImage);
                udb.updateUser(usernames[0]['id'], updateData);
                getUser();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("YES", style: TextStyle(color: HexColor("#036635"))),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("NO", style: TextStyle(color: HexColor("#036635"))),
            ),
          ],
        );
      },
    );
  }
}

