import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'common_things.dart';
import 'menu/bloc/menu_bloc.dart';
import 'menu/bloc/menu_states.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({Key? key}) : super(key: key);

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        persistentFooterButtons: [
          BlocBuilder<MenuBloc, MenuStates>(builder: (context, state) {
            if (state is AddedToCartState) {
              return viewInCart();
            } else {
              return Container();
            }
          }),
        ],
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          GiftCardDesign(
                            image: 'images/giftdiwali.png',
                            giftCardText:
                                'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                            price: 'Rs 659.00',
                            titleText: 'Celebrate With Starshmucks',
                            press: () {},
                          ),
                          const SizedBox(width: 10),
                          GiftCardDesign(
                            image: 'images/giftdiwali2.png',
                            giftCardText:
                                'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                            price: 'Rs.999.00',
                            titleText: 'Celebrate With Starshmucks',
                            press: () {},
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TabBar(
                    controller: tabController,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    // indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: HexColor("#175244"),

                    labelColor: Colors.black,
                    // unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    tabs: const <Widget>[
                      Tab(text: 'ALL'),
                      Tab(text: 'FEATURED'),
                      Tab(text: 'CONGRATULATIONS'),
                      Tab(text: 'THANK YOU'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const ScrollPhysics(),
                    controller: tabController,
                    children: <Widget>[
                      getAllCards(context),
                      getAllCards(context),
                      getAllCards(context),
                      getAllCards(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GiftCardDesign extends StatelessWidget {
  const GiftCardDesign({
    Key? key,
    required this.image,
    required this.giftCardText,
    required this.price,
    required this.titleText,
    required this.press,
  }) : super(key: key);
  final String image;
  final String titleText;
  final String giftCardText;

  final VoidCallback press;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: HexColor("#ede38c"), borderRadius: BorderRadius.circular(20)),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.79,
      child: Stack(
        children: [
          Container(
            transform: Matrix4.translationValues(5, 12, 0),
            child:
                Image.asset(image, width: 100, height: 100, fit: BoxFit.fill),
          ),
          Container(
            transform: Matrix4.translationValues(100, 10, 0),
            child: Text(
              titleText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            width: 200,
            transform: Matrix4.translationValues(100, 40, 0),
            child: Text(
              giftCardText,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(30, 130, 0),
            child: const AutoSizeText(
              'Starting from',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(30, 145, 0),
            child: AutoSizeText(
              price,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(200, 120, 0),
            child: TextButton(
              onPressed: press,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor("#175244")),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text('Gift Now'),
            ),
          )
        ],
      ),
    );
  }
}

getAllCards(context) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HexColor("#ade38c"),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(5, 12, 0),
                child: Image.asset(
                  'images/giftdiwali.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(110, 10, 0),
                child: const Text(
                  'Celebrate With Starshmucks',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                width: 220,
                transform: Matrix4.translationValues(110, 40, 0),
                child: const Text(
                  'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 130, 0),
                child: const AutoSizeText(
                  'Starting from',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 145, 0),
                child: const AutoSizeText(
                  'Rs.659.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(250, 120, 0),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#175244")),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Text('Gift Now'),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HexColor("#ede38c"),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(5, 12, 0),
                child: Image.asset(
                  'images/giftdiwali.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(110, 10, 0),
                child: const Text(
                  'Celebrate With Starshmucks',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                width: 220,
                transform: Matrix4.translationValues(110, 40, 0),
                child: const Text(
                  'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 130, 0),
                child: const AutoSizeText(
                  'Starting from',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 145, 0),
                child: const AutoSizeText(
                  'Rs.659.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(250, 120, 0),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#175244")),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Text('Gift Now'),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HexColor("#ade38c"),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(5, 12, 0),
                child: Image.asset(
                  'images/giftdiwali.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(110, 10, 0),
                child: const Text(
                  'Celebrate With Starshmucks',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                width: 220,
                transform: Matrix4.translationValues(110, 40, 0),
                child: const Text(
                  'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 130, 0),
                child: const AutoSizeText(
                  'Starting from',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 145, 0),
                child: const AutoSizeText(
                  'Rs.659.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(250, 120, 0),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#175244")),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Text('Gift Now'),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
