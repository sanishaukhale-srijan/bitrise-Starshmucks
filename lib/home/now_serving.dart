import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/home/widgets/home_item_list.dart';
import '../common_things.dart';
import '../model/menu_model.dart';

class NowServing extends StatefulWidget {
  const NowServing({Key? key}) : super(key: key);

  @override
  State<NowServing> createState() => _NowServingState();
}

class _NowServingState extends State<NowServing> {
  late MenuDB db;
  bool getDataStatus = false;
  List<MenuModel> nowServingData = [];
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

  getDataNowServing() async {
    nowServingData = await db.nowServeData();
    if (mounted) {
      setState(() {
        getDataStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataNowServing();
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: HomeItemList(data: nowServingData, fToast: fToast));
  }
}
