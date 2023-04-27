import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '/menu/smoothie_data.dart';
import '../database/menu_db.dart';
import '../model/menu_model.dart';
import 'cake_data.dart';
import 'coffee_data.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late TabController tabController;
  late MenuDB db;
  late var product;
  List<MenuModel> data = [];

  @override
  void initState() {
    db = MenuDB();
    db.initMenuDB();
    getData();
    putData();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  getData() async {
    data = await db.getMenuData();
    setState(() {});
  }

  putData() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString("json/menu.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['Menu'].length; item++) {
      product = MenuModel.fromJson(responseData['Menu'][item]);
      db.insertMenuData(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              indicatorColor: HexColor("#175244"),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.coffee, color: HexColor("#175244")),
                ),
                Tab(
                  icon: Icon(Icons.cake_outlined, color: HexColor("#175244")),
                ),
                Tab(
                  icon:
                      Icon(Icons.local_drink_sharp, color: HexColor("#175244")),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  const GetCoffeeData(),
                  const GetCakeData(),
                  GetSmoothieData(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
