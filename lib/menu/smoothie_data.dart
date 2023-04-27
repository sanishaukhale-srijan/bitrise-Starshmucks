import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/menu/widgets/menu_item_list.dart';
import '../common_things.dart';
import '../model/menu_model.dart';
import 'bloc/menu_bloc.dart';
import 'bloc/menu_states.dart';

class GetSmoothieData extends StatefulWidget {
  const GetSmoothieData(context, {Key? key}) : super(key: key);

  @override
  State<GetSmoothieData> createState() => _GetSmoothieDataState();
}

class _GetSmoothieDataState extends State<GetSmoothieData> {
  late MenuDB db;
  bool getDataStatus = false;
  List<MenuModel> data = [];
  late FToast fToast;

  @override
  void initState() {
    db = MenuDB();
    db.initMenuDB();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getSmoothieData() async {
    data = await db.smoothieData();
    if (mounted) {
      setState(() {
        getDataStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initCart();
    getSmoothieData();
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
          : const CircularProgressIndicator(),
    );
  }
}
