import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/database/menu_db.dart';
import '/database/orders_db.dart';
import '/database/user_db.dart';
import '/model/menu_model.dart';
import '/model/order_history.dart';
import '/order/widgets/cart_summary.dart';
import '/order/widgets/deliver_to.dart';
import '/order/widgets/item_list.dart';
import '/order/widgets/needhelp.dart';
import '/order/widgets/ordersummary.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late OrdersDB orderdb;
  late int? id = 0;
  List<OrderHistoryModel> orderdata = [];
  List<dynamic> idlistfromstring = [];
  List<dynamic> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  late double ttl = 0;
  late double cartTotal = 0;
  late double savings = 0;
  double delchar = 5;
  UserDB udb = UserDB();

  @override
  void initState() {
    getOrderId();
    getUser();
    getAddress();
    super.initState();
  }

  List<Map<String, dynamic>> userddt = [];

  late String selectedAddress = '';

  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});

    return selectedAddress;
  }

  getUser() async {
    userddt = await udb.getUserData();
    setState(() {});
  }

  getTotal() async {
    final total = await SharedPreferences.getInstance();
    savings = total.getDouble('savings')!;
    for (var i = 0; i < items1.length; i++) {
      cartTotal = cartTotal + double.parse(items1[i].price);
    }
    if (userddt[0]['tier'] == 'bronze') {
      ttl = (cartTotal + delchar) - savings;
    } else if (userddt[0]['tier'] == 'silver') {
      if (cartTotal > 50.0) {
        ttl = (cartTotal) - savings;
      } else {
        ttl = (cartTotal + delchar) - savings;
      }
    } else {
      ttl = (cartTotal) - savings;
    }
    setState(() {});
  }

  getOrderId() async {
    final prefs = await SharedPreferences.getInstance();
    id = (prefs.getInt('orderid'))!;
    await getOrderDetails(id);
    setState(() {});
  }

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
    setState(() {});
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderdata.isEmpty || items1.isEmpty || qtylistfromstring.isEmpty
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
                    title: Text('Order id: #$id',
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
                                      OrderSummary(orderData: orderdata),
                                      ItemList(
                                        qtyListFromString: qtylistfromstring,
                                        items: items1,
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      const SizedBox(height: 8),
                                      CartSummary(
                                        value: cartTotal,
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
    );
  }
}
