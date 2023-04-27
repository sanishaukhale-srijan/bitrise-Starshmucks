import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/menu/widgets/menu_item_list.dart';
import '../common_things.dart';
import '../model/menu_model.dart';
import 'bloc/menu_bloc.dart';
import 'bloc/menu_states.dart';

class GetCakeData extends StatefulWidget {
  const GetCakeData({Key? key}) : super(key: key);

  @override
  State<GetCakeData> createState() => _GetCakeDataState();
}

class _GetCakeDataState extends State<GetCakeData> {
  late MenuDB db;
  bool getDataStatus = false;
  List<MenuModel> data = [];
  late FToast fToast;

  @override
  void initState() {
    db = MenuDB();
    db.initMenuDB();
    getCakeData();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getCakeData() async {
    data = await db.cakeData();
    if (mounted) {
      setState(() {
        getDataStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initCart();
    getCakeData();
    return Scaffold(persistentFooterButtons: [
      BlocBuilder<MenuBloc, MenuStates>(builder: (context, state) {
        if (state is AddedToCartState) {
          return viewInCart();
        } else {
          return Container();
        }
      }),
    ], body: MenuItemList(data: data, fToast: fToast));
  }
}
