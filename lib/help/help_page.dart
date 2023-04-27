import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import '/help/widgets/build_expansion_tile_widget.dart';
import '/help/widgets/faq_widget.dart';
import '../common_things.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getHomeAppBar("Need Help?", [Container()], true, 0.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: HexColor("#175244"),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.05),
                    BlendMode.dstATop,
                  ),
                  image: const ExactAssetImage('images/shmucks.png'),
                ),
              ),
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "24/7",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Help Centre",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tell us how we can help.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: HexColor("#036635"),
                  ),
                ),
                Icon(
                  Icons.waving_hand_rounded,
                  color: HexColor("#175244"),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.center,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                "Our team of Superheros are standing by for service & support.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: HexColor("#036635"),
                ),
              ),
            ),
            const SizedBox(height: 30),
            BuildExpansionTile(
              text: "Chat",
              img: "images/chat.png",
              content: TextButton(
                onPressed: () async {
                  final mailUrl = Uri.parse(
                      'mailto:anish.keni@srijan.net?subject=News&body=New%20plugin');
                  if (await canLaunchUrl(mailUrl)) {
                    launchUrl(mailUrl);
                  } else {
                    throw 'Could not launch $mailUrl';
                  }
                },
                child: Text(
                  "Write to Us",
                  style: TextStyle(color: HexColor("#036635")),
                ),
              ),
            ),
            BuildExpansionTile(
              text: "FAQ",
              img: "images/faq.png",
              content: Column(
                children: const [
                  FaqTile(
                      title: "Can I edit my order?",
                      child:
                          "Your order can be edited before it reaches the restaurant. You could contact customer support team via call to do so. Once order is placed and restaurant starts preparing your food, you may not edit its contents"),
                  FaqTile(
                      title: "I want to cancel my order",
                      child:
                          "We will do our best to accommodate your request if the order is not placed to the restaurant (Customer service number:  1800999999). Please note that we will have a right to charge a cancellation fee up to full order value to compensate our restaurant and delivery partners if your order has been confirmed."),
                  FaqTile(
                      title: "Do you charge for delivery?",
                      child:
                          "Delivery fee varies from city to city and is applicable if order value is below a certain amount. Delivery fee (if any) is specified on the 'Review Order' page. "),
                  FaqTile(
                      title: "How long do you take to deliver?",
                      child:
                          "Standard delivery times vary by the location selected and prevailing conditions. Once you select your location, an estimated delivery time is mentioned for each outlet."),
                  FaqTile(
                      title: "Can I order in advance?",
                      child:
                          "We currently do not support this functionality. All our orders are placed and executed on-demand."),
                ],
              ),
            ),
            BuildExpansionTile(
              text: "Call Us",
              img: "images/call.png",
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call_outlined,
                      size: 25,
                      color: HexColor("#036635"),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final call = Uri.parse('tel:1800999999');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },
                    child: Text(
                      "1800999999",
                      style: TextStyle(
                        color: HexColor("#036635"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
