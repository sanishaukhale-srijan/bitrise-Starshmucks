import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key, this.items, this.qtyListFromString})
      : super(key: key);

  final items;
  final qtyListFromString;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: qtyListFromString.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: HexColor("#036635"),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          qtyListFromString[index] + "x",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            items[index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text("Regular",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: HexColor("#036635"))),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: Text(
                    "\$${items[index].price}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w100),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
