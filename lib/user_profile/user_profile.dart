import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/signin/signin.dart';
import '../common_things.dart';
import '../database/user_db.dart';
import '../editdetails/edit_details.dart';
import '../help/help_page.dart';
import '../menu/bloc/menu_bloc.dart';
import '../menu/bloc/menu_states.dart';
import '../order/order_history.dart';
import '../rewards/rewards.dart';
import 'widgets/profile_tile_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Map<String, dynamic>> usernames = [];
  late UserDB udb;

  getUser() async {
    usernames = await udb.getUserData();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    udb = UserDB();
    udb.initUserDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initCart();
    getUser();
    if (usernames.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        persistentFooterButtons: [
          BlocBuilder<MenuBloc, MenuStates>(builder: (context, state) {
            if (state is AddedToCartState) {
              return viewInCart();
            } else {
              return Container();
            }
          }),
        ],
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250.0,
                color: HexColor("#175244"),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: usernames[0]['image'] == ''
                            ? const DecorationImage(
                                image: AssetImage('images/profile1.jpg'))
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
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
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
                    ProfileTile(
                      text: 'My Account',
                      press: () {
                        Get.to(() => const EditProfile());
                      },
                      icon: Icons.account_circle_outlined,
                    ),
                    dividerForTiles,
                    ProfileTile(
                      text: 'Orders',
                      press: () {
                        Get.to(() => const Orders());
                      },
                      icon: Icons.coffee_outlined,
                    ),
                    dividerForTiles,
                    ProfileTile(
                      text: 'Rewards',
                      press: () {
                        Get.to(() => const Rewards());
                      },
                      icon: Icons.star_outline_sharp,
                    ),
                    dividerForTiles,
                    ProfileTile(
                      text: 'Help',
                      press: () {
                        Get.to(() => const Help());
                      },
                      icon: Icons.help_outline_rounded,
                    ),
                    dividerForTiles,
                    ProfileTile(
                      text: 'Logout',
                      press: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('signedInEmail');
                        Get.to(() => const SigninPage());
                      },
                      icon: Icons.logout,
                    ),
                    dividerForTiles,
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

var dividerForTiles = Divider(
  color: HexColor("#036635"),
  height: 1,
  thickness: 0.5,
  indent: 0,
  endIndent: 0,
);
