import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '/common_things.dart';
import '/database/wishlist_db.dart';
import '/model/wishlist_model.dart';
import 'database/menu_db.dart';
import 'model/menu_model.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool ischecked = false;
  late WishlistDB wdb;
  late MenuDB menudb;
  late List<MenuModel> kart = [];
  late List<WishlistModel> datalist = [];
  List<WishlistModel> wishlist = [];
  var route;

  @override
  void initState() {
    menudb = MenuDB();
    menudb.initMenuDB();
    wdb = WishlistDB();
    wdb.initWishlistDB();
    getDataOnIds();
    super.initState();
  }

  getDataOnIds() async {
    datalist = await wdb.getWishlistData();
    List<MenuModel> wishlistTmp = [];
    for (var i = 0; i < datalist.length; i++) {
      var wdata = await menudb.getElementOnIdMenu(datalist[i].id);
      if (wdata.length == 1) {
        wishlistTmp.add(wdata.first);
      }
    }
    kart = wishlistTmp;
    mounted ? setState(() {}) : null;
  }

  Future<bool> onWillPop() async {
    return (await Get.to(() => const BottomBar(),
            transition: Transition.leftToRight)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    getDataOnIds();
    return Scaffold(
      backgroundColor: Colors.white,
      body: datalist == null
          ? const CircularProgressIndicator()
          : WillPopScope(
              onWillPop: onWillPop,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          onWillPop();
                        },
                      ),
                      elevation: 4,
                      backgroundColor: Colors.white,
                      foregroundColor: HexColor("#175244"),
                      title: const Text('Wishlist'),
                    ),
                  ];
                },
                body: datalist.isEmpty
                    ? Center(
                        child: Text(
                          "Nothing in Wishlist",
                          style: TextStyle(
                              color: HexColor("#175244"),
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
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
                                            Image.asset(kart[index].image,
                                                height: 100, width: 100),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                            .ellipsis),
                                                  ),
                                                  Text(
                                                    "\$ ${kart[index].price}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      removeFromWishlist(
                                                          datalist[index],
                                                          context);

                                                      setState(() {});
                                                    },
                                                    style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(HexColor(
                                                                  "#036635")),
                                                    ),
                                                    child: const Text(
                                                      'Remove',
                                                    ),
                                                  ),
                                                ],
                                              ),
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
            ),
    );
  }
}
