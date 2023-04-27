import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '/home/home_screen.dart';
import 'common_things.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

var product;

getItem(item) {
  product = item;
}

class _ProductDetailState extends State<ProductDetail> {
  late List<int> ids = [];
  late FToast fToast;

  @override
  void initState() {
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    bool status = false;
    for (var i = 0; i < ids.length; i++) {
      if (ids[i] == product.id) status = true;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      persistentFooterButtons: cartInit ? [viewInCart()] : null,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            addToCart(product.id);
            cartInit = true;
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(HexColor("#036635")),
          ),
          child: const Text("Add To Cart"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://picsum.photos/id/1060/536/354.jpg?blur=5",
                      scale: 4),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                        0, MediaQuery.of(context).size.height * 0.25, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      product.image,
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.50,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: product.category == 'cake'
                  ? const EdgeInsets.only(top: 0)
                  : const EdgeInsets.only(top: 60),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.2,
                right: MediaQuery.of(context).size.width * 0.2,
              ),
              transform: Matrix4.translationValues(
                  0, MediaQuery.of(context).size.height * -0.15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(product.category),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(product.quantity),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.2,
                right: MediaQuery.of(context).size.width * 0.2,
              ),
              transform: Matrix4.translationValues(
                  0, MediaQuery.of(context).size.height * -0.12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Calories",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text("40cals / 100gms", maxLines: 2),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Ratings",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(product.rating),
                          const Icon(Icons.star,
                              color: Colors.amberAccent, size: 20)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              transform: Matrix4.translationValues(
                  0, MediaQuery.of(context).size.height * -0.07, 0),
              child: Text(
                product.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(
                  0, MediaQuery.of(context).size.height * -0.05, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "\$" + product.price,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurStyle: BlurStyle.solid,
                          blurRadius: 20,
                          color: Colors.grey, //New
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: HexColor("#175244"),
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 7.0, right: 10, bottom: 10, top: 10),
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              transform: Matrix4.translationValues(
                  0, MediaQuery.of(context).size.height * -0.03, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Description:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text(product.description,
                      style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
