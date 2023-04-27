import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/menu/bloc/menu_bloc.dart';
import 'package:starshmucks/menu/bloc/menu_events.dart';
import 'package:starshmucks/menu/bloc/menu_states.dart';

import '/common_things.dart';
import '../../model/wishlist_model.dart';

class MenuItemList extends StatelessWidget {
  const MenuItemList({Key? key, this.data, required this.fToast})
      : super(key: key);
  final data;
  final FToast fToast;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        bool status = false;
        for (var i = 0; i < ids.length; i++) {
          if (ids[i] == data[index].id) {
            status = true;
          }
        }
        return GestureDetector(
          onTap: () {
            BlocProvider.of<MenuBloc>(context).add(OnTapEvent(data[index]));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: HexColor("#175244"), width: 0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Image.asset(
                    data[index].image,
                    width: 120,
                    height: 120,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 150,
                        child: AutoSizeText(
                          data[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        " \$ ${data[index].price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Row(
                        children: <Widget>[
                          AutoSizeText(
                            data[index].rating,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                            minFontSize: 12,
                            maxFontSize: 18,
                          ),
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amberAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<MenuBloc, MenuStates>(
                          builder: (context, state) => IconButton(
                              onPressed: () {
                                //int id = odata[index].id;
                                status
                                    ? BlocProvider.of<MenuBloc>(context).add(
                                        OnRemoveFromWishlistEvent(
                                            WishlistModel(id: data[index].id),
                                            context))
                                    : BlocProvider.of<MenuBloc>(context).add(
                                        OnAddToWishlistEvent(data[index].id));
                                getIds();
                              },
                              icon: Icon(
                                //not rebuilding because of status
                                status ? Icons.favorite : Icons.favorite_border,
                                color: HexColor("#036635"),
                              ))),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<MenuBloc>(context)
                              .add(OnAddToCartEvent(data[index].id, fToast));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              index % 2 == 0
                                  ? Colors.teal
                                  : Colors.deepOrangeAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
