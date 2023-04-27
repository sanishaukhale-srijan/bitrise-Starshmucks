import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common_things.dart';
import '/database/cart_db.dart';
import '/database/menu_db.dart';
import '/database/orders_db.dart';
import '/home/home_screen.dart';
import '/model/menu_model.dart';
import '/model/order_history.dart';
import '/order/widgets/cart_summary.dart';
import '/order/widgets/deliver_to.dart';
import '/order/widgets/item_list.dart';
import '/order/widgets/needhelp.dart';
import '/order/widgets/ordersummary.dart';
import '../database/user_db.dart';
import '../model/cart_model.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  late OrdersDB db;
  late CartDB cartdb;
  List<OrderHistoryModel> orderData = [];
  List<CartModel> cartlist = [];
  List<String> idlistfromstring = [];
  List<String> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  late double ttl = 0;
  late double cartttl = 0;
  late double savings = 0;
  late UserDB udb;
  double delchar = 5;
  late int orderid = 0;

  @override
  void initState() {
    udb = UserDB();
    udb.initUserDB();
    db = OrdersDB();
    db.initOrdersDB();
    cartdb = CartDB();
    cartdb.initCartDB();
    getUser();
    getAddress();
    super.initState();

    cartInit = false;
  }

  List<Map<String, dynamic>> userddt = [];

  getUser() async {
    userddt = await udb.getUserData();
    getttl();
    getorderid();
    setState(() {});
  }

  getttl() async {
    final total = await SharedPreferences.getInstance();
    cartttl = total.getDouble('total')!;
    savings = total.getDouble('savings')!;
    if (userddt[0]['tier'] == 'bronze') {
      ttl = (cartttl + delchar) - savings;
    } else if (userddt[0]['tier'] == 'silver') {
      if (cartttl > 50.0) {
        ttl = (cartttl) - savings;
      } else {
        ttl = (cartttl + delchar) - savings;
      }
    } else {
      ttl = (cartttl) - savings;
    }
  }

  getDataIds() async {
    MenuDB menudb = MenuDB();
    menudb.initMenuDB();
    db.initOrdersDB();
    orderData = await db.getOrdersData();
    for (var i = 0; i < orderData.length; i++) {
      idlistfromstring = orderData[i].id!.split(' ');
      qtylistfromstring = orderData[i].qty!.split(' ');
    }
    for (var i = 0; i < idlistfromstring.length; i++) {
      items = await menudb.getItemWithIdOrder(idlistfromstring[i]);
      items1.add(items.first);
    }
    setState(() {});
  }

  getorderid() async {
    db.initOrdersDB();
    Map<dynamic, dynamic> orderlist = await db.getAllData();
    orderid = orderlist.length;
  }

  late String selectedAddress = '';

  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});
    return selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    getDataIds();
    return WillPopScope(
        onWillPop: goHomeFromSuccess,
        child: Scaffold(
          body: orderData.isEmpty || items1.isEmpty || qtylistfromstring.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      backgroundColor: Colors.white,
                      foregroundColor: HexColor("#175244"),
                      expandedHeight: 150.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Order id: #$orderid',
                            style: TextStyle(
                              color: HexColor("#175244"),
                            )),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DeliverTo(selectedAddress: selectedAddress),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                width: MediaQuery.of(context).size.width * 1,
                                child: Card(
                                    elevation: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          OrderSummary(orderData: orderData),
                                          ItemList(
                                              items: items1,
                                              qtyListFromString:
                                                  qtylistfromstring),
                                          const Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                          ),
                                          const SizedBox(height: 8),
                                          CartSummary(
                                            value: cartttl,
                                            text: "Subtotal",
                                            wt: FontWeight.w600,
                                            textsize: 15,
                                          ),
                                          const SizedBox(height: 8),
                                          CartSummary(
                                            value: savings,
                                            text: 'Points savings',
                                            wt: FontWeight.w300,
                                            textsize: 15,
                                          ),
                                          const SizedBox(height: 8),
                                          const CartSummary(
                                            value: 5.00,
                                            text: 'Delivery Charges',
                                            wt: FontWeight.w300,
                                            textsize: 15,
                                          ),
                                          const SizedBox(height: 8),
                                          const Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                          ),
                                          const SizedBox(height: 8),
                                          CartSummary(
                                            value: ttl,
                                            text: 'Total',
                                            wt: FontWeight.w900,
                                            textsize: 18,
                                          ),
                                          const SizedBox(height: 8),
                                          const Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              const NeedHelp(),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),
        ));
  }
}
