import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/common_things.dart';
import '/home/widgets/home_item_list.dart';
import '../database/menu_db.dart';
import '../model/menu_model.dart';

class GetOffers extends StatefulWidget {
  const GetOffers({Key? key}) : super(key: key);

  @override
  State<GetOffers> createState() => _GetOffersState();
}

class _GetOffersState extends State<GetOffers> {
  late MenuDB db;
  bool getDataStatus = false;
  List<MenuModel> offersData = [];
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

  getDataOffers() async {
    offersData = await db.offersData();
    if (mounted) {
      setState(() {
        getDataStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataOffers();
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: HomeItemList(data: offersData, fToast: fToast));
  }
}
