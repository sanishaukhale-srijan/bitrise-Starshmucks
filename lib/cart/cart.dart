import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starshmucks/menu/bloc/menu_states.dart';

import '/database/cart_db.dart';
import '/home/home_screen.dart';
import '/model/cart_model.dart';
import '../address_payment/address_payment.dart';
import '../database/menu_db.dart';
import '../database/orders_db.dart';
import '../menu/bloc/menu_bloc.dart';
import '../model/menu_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool ischecked = false;

  late CartDB cartdb;
  late MenuDB menudb;
  late OrdersDB orderdb;
  late List<MenuModel> kart = [];
  late List<CartModel> datalist = [];
  late List<CartModel> qtylist = [];
  List<CartModel> cartlist = [];
  late double ttl = 0;

  @override
  void initState() {
    menudb = MenuDB();
    menudb.initMenuDB();
    cartdb = CartDB();
    cartdb.initCartDB();
    getDataOnIds();
    super.initState();
  }

  getDataOnIds() async {
    datalist = await cartdb.getCartData();
    List<MenuModel> kartTemp = [];
    double tempTotal = 0;
    for (var i = 0; i < datalist.length; i++) {
      var kartData = await menudb.getElementOnIdMenu(datalist[i].id);

      if (kartData.length == 1) {
        tempTotal += (double.parse(kartData.first.price) * datalist[i].qty);
        kartTemp.add(kartData.first);
      }
    }
    kart = kartTemp;
    ttl = tempTotal;
    setState(() {});
  }

  removeFromCart(id) {
    datalist.isEmpty ? cartInit = false : cartInit = true;
    BlocProvider.of<MenuBloc>(context).emit(MenuInitialState());
    cartdb.removeItemFromCart(id);
    getDataOnIds();
  }

  increaseQuantity(id) {
    cartdb.increaseQty(id);
    getDataOnIds();
  }

  decreaseQuantity(id) {
    cartdb.decreaseQty(id);
    getDataOnIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            final total = await SharedPreferences.getInstance();
            await total.setDouble('total', ttl);
            Get.to(() => const Address(), transition: Transition.rightToLeft);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),
          child: const Text("Checkout"),
        ),
      ),
      persistentFooterButtons: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 35,
                        color: HexColor("#175244"),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$${ttl.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 35,
                        color: HexColor("#175244"),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Text("( Inclusive of packaging charge )"),
            ],
          ),
        )
      ],
      body: datalist == null
          ? const CircularProgressIndicator()
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 120,
                    backgroundColor: Colors.white,
                    foregroundColor: HexColor("#175244"),
                    title: const Text(''),
                    pinned: false,
                    flexibleSpace: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Order",
                            style: TextStyle(
                              fontSize: 30,
                              color: HexColor("#175244"),
                            ),
                          ),
                          Text(
                            "Summary",
                            style: TextStyle(
                                fontSize: 35,
                                color: HexColor("#175244"),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: datalist.isEmpty
                  ? Center(
                      child: Text(
                        "No items in cart.",
                        style: TextStyle(
                          fontSize: 15,
                          color: HexColor("#175244"),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: datalist.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            kart[index].image,
                                            height: 100,
                                            width: 100,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                        kart[index].title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                                Text(
                                                  "\$ ${kart[index].price}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    removeFromCart(
                                                        datalist[index]);
                                                  },
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      HexColor("#036635"),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Remove',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.remove),
                                                    onPressed: () {
                                                      if (datalist[index].qty ==
                                                          1) {
                                                        removeFromCart(
                                                            datalist[index]);
                                                      } else {
                                                        decreaseQuantity(
                                                            datalist[index]);
                                                      }
                                                      setState(() {});
                                                    },
                                                    style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        HexColor("#036635"),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    datalist[index]
                                                        .qty
                                                        .toString(),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.add),
                                                    onPressed: () {
                                                      increaseQuantity(
                                                        datalist[index],
                                                      );
                                                    },
                                                    style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        HexColor("#036635"),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
