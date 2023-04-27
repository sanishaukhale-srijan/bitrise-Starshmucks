import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/database/orders_db.dart';
import '/model/order_history.dart';
import '../common_things.dart';
import '../database/menu_db.dart';
import '../model/menu_model.dart';
import 'order_details.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late Map<dynamic, dynamic> data = {};
  late List<dynamic> data1 = [];
  late OrdersDB orderdb;
  List<dynamic> idlistfromstring = [];
  List<dynamic> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  List<OrderHistoryModel> orderdata = [];

  getOrderDetails(id) async {
    MenuDB menuDb = MenuDB();
    menuDb.initMenuDB();
    orderdb = OrdersDB();
    orderdb.initOrdersDB();
    orderdata = await orderdb.getOrdersDataOnID(id);
    for (var i = 0; i < orderdata.length; i++) {
      idlistfromstring = orderdata[i].id!.split(' ');
      qtylistfromstring = orderdata[i].qty!.split(' ');
    }
    for (var i = 0; i < idlistfromstring.length; i++) {
      items = await menuDb.getItemWithIdOrder(idlistfromstring[i]);
      items1.add(items.first);
    }
    getTotal();
    setState(() {});
  }

  @override
  void initState() {
    orderdb = OrdersDB();
    orderdb.initOrdersDB();
    getOrderData();
    super.initState();
  }

  getOrderData() async {
    data = await orderdb.getAllData();
    data1.addAll(data.keys);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar("Orders", [Container()], true, 0.0),
      body: data1.isEmpty
          ? Center(
              child: Text(
                "No Orders Found",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: HexColor("#175244"),
                ),
              ),
            )
          : ListView.separated(
              itemCount: data1.length,
              itemBuilder: (context, index) {
                var res = index + 1;
                getOrderDetails(res);
                return ListTile(
                  trailing: TextButton.icon(
                    onPressed: () {
                      getDetails(res);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black38,
                    ),
                    label: const Text(""),
                  ),
                  leading: CircleAvatar(
                    radius: 60,
                    child: items1.isEmpty
                        ? const Text("image")
                        : Image.asset(
                            items1[index].image,
                          ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  title: Text(
                    "Order id: #$res",
                    style: TextStyle(
                      fontSize: 16,
                      color: HexColor("#175244"),
                    ),
                  ),
                  subtitle: const Text(
                    "Order Placed",
                    style: TextStyle(fontSize: 16, color: Colors.black38),
                  ),
                  onTap: () async {
                    getDetails(res);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
    );
  }
}

getDetails(res) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('orderid', res);
  Get.to(transition: Transition.rightToLeft, () => const OrderDetails());
}
