import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/menu/widgets/menu_item_list.dart';
import '../common_things.dart';
import '../model/menu_model.dart';
import 'bloc/menu_bloc.dart';
import 'bloc/menu_states.dart';

class GetCoffeeData extends StatefulWidget {
  const GetCoffeeData({Key? key}) : super(key: key);

  @override
  State<GetCoffeeData> createState() => _GetCoffeeDataState();
}

class _GetCoffeeDataState extends State<GetCoffeeData> {
  late MenuDB menuDB;
  bool getDataStatus = false;
  List<MenuModel> data = [];
  late MenuDB db;
  late FToast fToast;

  @override
  void initState() {
    menuDB = MenuDB();
    menuDB.initMenuDB();
    getCoffeeData();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getCoffeeData() async {
    data = await menuDB.coffeeData();
    if (mounted) {
      setState(() {
        getDataStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initCart();
    getCoffeeData();
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
      body: getDataStatus
          ? MenuItemList(data: data, fToast: fToast)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
